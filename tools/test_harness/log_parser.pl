:-module(log_parser, [report_result_files_counts/1
                     ,rename_files_with_errors/2
                     ,analyse_logs/2
                     ,print_log_info/1
                     ,parse_logs/2
                     ]).

:- use_module(test_harness).

% Input to grammar rules will be handled as character code lists.
:-user:set_prolog_flag(back_quotes, codes).
% When tracing, lists of character codes will be displayed as atoms.
:- portray_text(true).

/** <module> A parser for Metta test log files.

*/

% Turn on debugging for log_parser topics.

% Turn off for all topics.
:-nodebug(_).
% Turn on for log analyser
:-debug(analyse_logs).
% Turn on for log parser
:-debug(parsed_logs).
% Turn on for test output. Careful: that's a lot of output.
%:-debug(log_lines).
% Turn on for rename operations on result files.
:-debug(rename_logs).
% test_harness topics; must be re-activated here to log them.
:-debug(run_timed_out).
:-debug(deleted_file).
:-debug(run_tests).
:-debug(exec_command).
:-debug(was_answers_file_written).
:-debug(shell_code_action).
:-debug(renamed_file).


%!      analyse_logs_timeout(?Timeout) is semidet.
%
%       Timeout, in seconds, for log parsing in analyse_logs/2.
%
analyse_logs_timeout(60).


%!      report_result_fiels_counts(+Directory) is det.
%
%       Report the counts of test result files in a Directory.
%
%       Searches a directory for result files and reports the counts of
%       each kind of file, by extension. Directories are searched
%       recursively and following symbolic links.
%
%       Test results files include all files with extensions defined in
%       the last argument of result_code_extension/3 (e.g. "timeout",
%       "aborted", etc) including "answers". See that predicate for
%       details.
%
%       This predicate goes over all results files and parses their
%       contents looking for lines that start with an error term, such
%       as "[(Error ", or "[(H-E-Fails (Error " etc. If an error line is
%       found the file is renamed with the extension defined in the
%       third argument of result_code_extension/3 for the result
%       "test_error" (found in its first argument). That extension is
%       normally "test_error" also.
%
%       Example run:
%       ==
%       ?- _Dir = 'test-suite', report_result_files_counts(_Dir).
%       Extension     Files
%       -------------------
%       metta          1398
%       answers         804
%       unknown_error    50
%       timeout          46
%       aborted           3
%       SIGKILLED        10
%       test_error      485
%       true.
%       ==
%
report_result_files_counts(Dir):-
        findall(E_
               ,(test_harness:result_code_extension(_R,_C,E)
                ,(atomic_list_concat(As,'.',E)
                 ,last(As,E_)
                 )
                )
               ,Es)
        ,count_result_files(Dir,[metta|Es],Zs)
        ,max_atom_length(Zs,M)
        ,format('~w~t~w~*|~n',['Extension','Files',M])
        ,format('~`-t~*|~n',[M])
        ,forall(member(E-C,Zs)
               ,(arg(1,C,N)
                %,format('~w ~w~n',[E,N])
                ,format('~w~t~w~*|~n',[E,N,M])
                )
               ).

%!      max_atom_length(+Pairs,-Max) is det.
%
%       Maximum length of a pair of atoms in list Pairs.
%
%       Pairs is a list of key-value pairs, where the key is a file
%       extension and the value a count, as returned by
%       count_result_files/3.
%
%       Max is the maximum length of an atom concatenating a key and its
%       value in Pairs.
%
%       Used to calculate the position, in characters, of a format/2
%       tab, for pretty-printing of reult counts in
%       report_result_files_counts/1.
%
max_atom_length(Ps,N):-
        setof(Ni
             ,E^C^Ps^A^(member(E-C,Ps)
                       ,format(atom(A),'~w ~w',[E,C])
                       ,atom_length(A,Ni)
                       )
             ,Ns)
        ,reverse(Ns,[N|_Rs]).


%!      count_result_files(+Directory,+Extensions,-Pairs) is det.
%
%       Count result files in a Directory.
%
%       Directory is the directory to search for result files. This
%       predicate follows symbolic links and searches sub-directories
%       rescursively.
%
%       Extensions is a list of file extensions to search for.
%
%       Pairs is a list of key-value pairs E-C, where E one of the
%       extensions in Extensions and C the count of files with that
%       extension found by this predicate.
%
count_result_files(Dir,Es,Zs):-
        length(Es,N)
        ,init_counter(N,Cs)
        ,forall(directory_member(Dir,F,[recursive(true)
                                       ,extensions(Es)
                                       ,follow_links(true)
                                       ]
                                )
               ,increment_counters(F,Es,Cs)
               )
        ,findall(Ei-Ci
                ,(nth1(I,Es,Ei)
                 ,nth1(I,Cs,Ci)
                 )
                ,Zs).


%!      increment_counters(+File,+Extensions,?Counters) is det.
%
%       Increment one of a list of Counters.
%
%       File is a file name. We want to increment by one the count of
%       files with that extension currently known.
%
%       Extensions is a list of extensions that should include the
%       extension of File.
%
%       Counters is a list of compounds c(I) where each I is the count
%       of files with one of the extensions in Extensions. Counters and
%       Extensions have the same length and the counter corresponding to
%       an extension E in Extensions should be in the same position, L,
%       in the list Counters, as E is in Extensions.
%
%       This predicate destructively updates counter compounds.
%
increment_counters(F,Es,Cs):-
        file_name_extension(_B,E,F)
        ,nth1(I,Es,E)
        ,nth1(I,Cs,C)
        ,increment_counter(C).


%!      init_counter(+Numbert,-Counters) is det.
%
%       Initialise a list of Counters.
%
%       Number is the number of counters to initialise.
%
%       Counters is a list of compounds c(I), of length Numbers. Each
%       counter has its own I variable, unshared with others.
%
init_counter(N,Cs):-
        findall(c(0)
               ,between(1,N,_)
               ,Cs).


%!      rename_files_with_errors(+Mode,+Directory) is det.
%
%       Analyse test answer files and rename those that failed tests.
%
%       Mode is one of: [run, dry_run]. If Mode is "run" result files
%       are renamed as described below). If Mode is "dry_run" no files
%       are renamed, but logging output reports that they are so that
%       you can sanity-check results.
%
%       Directory is the directory of the answer files to be analysed.
%       Directory can be a symbolic link.
%
%       Test answer files have the extension defined in the third
%       argument of result_code_extension/3, for the result test
%       "success". This is normally going to be the extension
%       ".answers".
%
%       Parsing timeout
%       ---------------
%
%       Parsing some result files may take too long. You can set an
%       appropriate timeout in analyse_logs_timeout/1. E.g.:
%       ==
%       analyse_logs_timeout(60).
%       ==
%
%       Note that unlike generate_answers/3, this predicate will _not_
%       rename any timeout files. Files that timeout during parsing can
%       be found by keeping a user protocol as described below.
%
%       Examoles of use
%       ---------------
%
%       Example of a dry run (no result files renamed):
%       ==
%       % Turn on debugging to report actions.
%       ?- debug(analyse_logs),debug(parsed_logs),debug(rename_logs).
%       true.
%
%       % Create a session protocol to capture results:
%       ?- protocol('log_parser_dry_run.log').
%       true.
%
%       % Start the dry run:
%       ?- _Dir = 'test-suite', rename_files_with_errors(dry_run,_Dir).
%       % Parsing log file test-suite/baseline_compat/anti-regression/bchain.metta.answers
%       Parsing log file
%       test-suite/baseline_compat/anti-regression/bchain_comp.metta.answers
%       Parsing log file
%       test-suite/baseline_compat/anti-regression/bc_comp.metta.answers
%       % ...
%       % ... more debug logs.
%       % ...
%       % Answers file test-suite/zebra/zebra3.metta.answers has test errors.
%       Renamed answers file to test-suite/zebra/zebra3.metta.test_error
%       Found 1289 anwers files
%       Timed-out while parsing 3 files
%       Renamed 485 answers files with errors
%       true.
%
%       % Turn off protocolling.
%       ?- noprotocol.
%       true.
%       ==
%
%       To log the parsed lines turn on the log_lines topic:
%       ==
%       debug(log_lines).
%       ==
%
%       Example of a full run (result files will be renamed):
%       ==
%       % Turn on debugging to report actions.
%       ?- debug(analyse_logs),debug(parsed_logs),debug(rename_logs).
%       true.
%
%       % Start protocolling to capture output:
%       ?- protocol('log_parser_full_run.log').
%       true.
%
%       % Start the full run:
%       ?- _Dir = 'test-suite', rename_files_with_errors(run,_Dir).
%
%       ==
%
%
rename_files_with_errors(R,Dir):-
        C0 = c(0)
        ,C1 = c(0)
        ,C2 = c(0)
        ,analyse_logs_timeout(T)
        ,once( test_harness:result_code_extension(test_error,_,Er) )
        ,forall(directory_member(Dir,F,[recursive(true)
                                       ,extensions([answers])
                                       ,follow_links(true)
                                       ]
                                )
               ,(debug(rename_logs,'Parsing log file ~w',[F])
                ,increment_counter(C0)
                ,(   parsed_logs(C1,F,T,Ps)
                    ,error_result(Ps)
                 ->  debug(rename_logs,'Answers file ~w has test errors.',[F])
                    ,test_harness:new_file_extension(F,_,Er,F_)
                    ,test_harness:renamed_file(R,F,F_)
                    ,increment_counter(C2)
                    ,debug_log_lines(Ps)
                 ;   true
                 )
                )
               )
        ,maplist(arg(1),[C0,C1,C2],[N0,N1,N2])
        ,debug(analyse_logs,'Found ~w anwers files',[N0])
        ,debug(rename_logs,'Timed-out while parsing ~w files',[N1])
        ,debug(analyse_logs,'Renamed ~w answers files with errors',[N2]).



%!      analyse_logs(+Directory,-Errors) is det.
%
%       Analyse the logs in a Directory and report the number of Errors.
%
%       This predicates parses answers files in a directory looking for
%       error lines, similar to rename_files_with_errors/2. Unlike that
%       predicate it doesn't rename any files and only reports the
%       counts of files with errors.
%
%       Directory is the file containing logs to be analysed.
%
%       Errors is a list [N0,N1,N2] of compounds c(I), where I is the
%       count of: all the result files parsed, files for which parsing
%       timed-out, files with error lines, respectively.
%
%       The timeout interval for parsing answers files is taken from the
%       argument of analyse_logs_timeout/1:
%       ==
%       analyse_logs_timeout(60).
%       ==
%
analyse_logs(Dir,[N0,N1,N2]):-
        C0 = c(0)
        ,C1 = c(0)
        ,C2 = c(0)
        ,analyse_logs_timeout(T)
        ,forall(directory_member(Dir,F,[recursive(true)
                                       ,extensions([answers])
                                       ,follow_links(true)
                                       ]
                                )
               ,(debug(analyse_logs,'Parsing log file ~w',[F])
                ,increment_counter(C0)
                ,(   parsed_logs(C1,F,T,Ps)
                    ,error_result(Ps)
                 ->  increment_counter(C2)
                    ,debug(analyse_logs,'Answers file ~w has test errors.',[F])
                    ,debug_log_lines(Ps)
                 ;   true
                 )
                )
               )
        ,arg(1,C0,N0)
        ,arg(1,C1,N1)
        ,arg(1,C2,N2)
        ,debug(analyse_logs,'Analysed ~w anwers files',[N0])
        ,debug(analyse_logs,'Timed-out while parsing ~w files',[N1])
        ,debug(analyse_logs,'Found ~w answers files with errors',[N2]).


%!      error_result(+Parse) is det.
%
%       True when an answer file Parse contains an error term.
%
error_result(Ps):-
        memberchk(error(_E),Ps)
        ,!.
error_result(Ps):-
        memberchk(hacked_error(_E),Ps)
        ,!.
error_result(Ps):-
        memberchk(expected(_E),Ps).


%!      parsed_logs(+File,+Limit,-Parse) is det.
%
%       Parse a metta test script log file.
%
parsed_logs(C,F,T,Ps):-
        G = parse_logs(F,Ps)
        ,CwTL = call_with_time_limit(T,G)
        ,Rec = (debug(parsed_logs,'Parsing ~w exceeded ~w sec time limit',[F,T])
               ,increment_counter(C)
               ,fail
               )
        ,catch(CwTL,time_limit_exceeded,Rec).


%!      increment_counter(+Counter) is det.
%
%       Increment a counter, destructively.
%
%       Counter is a compound C(I) where I is a number, the count
%       recorded by the counter so far.
%
increment_counter(C):-
        arg(1,C,I)
        ,succ(I,J)
        ,nb_setarg(1,C,J).


%!      debug_log_lines(+Parsed) is det.
%
%       Debug information about a parsed metta test log.
%
debug_log_lines(Ps):-
        debug(log_lines,'Parsed log lines:',[])
        ,forall(member(P,Ps)
              ,(deparse(P,D)
               ,debug(log_lines,'~w',[D])
               )
              ).


%!      print_log_info(+Parsed) is det.
%
%       Print information about a parsed metta test log.
%
print_log_info(Ps):-
        forall(member(P,Ps)
              ,(deparse(P,D)
               ,writeln(D)
               )
              ).

%!      deparse(+Expression,-Deparsed) is det.
%
%       Transform a parsed expression to a pretty-printing atom.
%
deparse(success, A):-
        once( phrase(vagina_painting,P) )
        ,atom_codes(A,P).
deparse(hacked_error(Es), A):-
        atom_codes(E,Es)
        ,format(atom(A), 'Overridden Error:~w', E).
deparse(error(Es), A):-
        atom_codes(E,Es)
        ,format(atom(A), 'Error: ~w', E).
deparse(exception(Ss,Es), A):-
        atom_codes(E,Es)
        ,atom_codes(S,Ss)
        ,format(atom(A), '~w ~w', [S,E]).
deparse(expected(Es), A):-
        atom_codes(E,Es)
        ,format(atom(A), 'Expected: ~w', E).
deparse(got(Es), A):-
        atom_codes(E,Es)
        ,format(atom(A), 'Got: ~w', E).
deparse(result(Rs,Es), A):-
        atom_codes(E,Es)
        ,atom_codes(R,Rs)
        ,format(atom(A), '~w ~w', [R,E]).



%!      parse_logs(+Filename,-Lines) is det.
%
%       Parse all Lines from a metta test answer file.
%
%       Filename is the file name of the file to read.
%
%       Lines is the lines in the given file, parsed into Prolog terms.
%
parse_logs(F,Ps):-
        read_lines(F,Ls)
        ,parse_lines(Ls,Ps).


%!      read_lines(+File, -Lines) is det.
%
%       Read lines from a File until the end_of_file marker.
%
read_lines(F,Ls):-
        O = (expand_file_search_path(F,F_)
            ,open(F_,read,S,[alias(input_file)
                      ,close_on_abort(true)
                      ])
            )
        ,R = read_lines(S,[],Ls)
        ,C = close(S)
        ,setup_call_cleanup(O,R,C).

%!      read_lines(+Stream,+Acc,-Lines) is det.
%
%       Business end of read_lines/2.
%
read_lines(S,Acc,Bind):-
        read_line_to_codes(S,Cs)
        ,is_list(Cs)
        ,!
        % For developing only
        ,atom_codes(A,Cs)
        ,read_lines(S,[A|Acc],Bind).
read_lines(S,Acc,Ls):-
        read_line_to_codes(S,end_of_file)
        ,reverse(Acc,Ls).


%!      parse_lines(+Lines, -Parsed) is det.
%
%       Parse Lines from a file to log info terms.
%
parse_lines(Ls, Ps):-
        parse_lines(Ls, [], Ps).

%!      parse_lines(+Lines, +Acc, -Parsed) is det.
%
%       Business end of parse_lines/2.
%
parse_lines([], Acc, Ls):-
        reverse(Acc, Ls)
        ,!.
parse_lines([L|Ls], Acc, Bind):-
        atom_codes(L, Cs)
        ,phrase(log_lines(S), Cs)
        ,!
        ,parse_lines(Ls,[S|Acc],Bind).
parse_lines([_L|Ls], Acc, Bind):-
        parse_lines(Ls, Acc, Bind).


% Parses error expressions breaking over lines
% Hopefully those'll break in a consistent manner.
%
% TODO: this parser can be made much faster by defining error lines etc
% in their own rules and calling those from clauses of log_lines//1.
%
log_lines(success) --> vagina_painting.
log_lines(hacked_error([E|Es])) -->
        lsb
          ,lp
            ,error_hack
             ,lp
             % Some times Eror is wrapped in parens.
             ,optional(lp)
               ,error, [E|Es], { phrase(star,[E|Es]) }.

log_lines(error([E|Es])) -->
        lsb
          ,lp
          ,optional(lp)
            ,error, [E|Es], { phrase(star,[E|Es]) }.


/*
log_lines(exception([S|Ss],[E|Es])) -->
            [S|Ss], { phrase(star, [S|Ss]) }, [E|Es], { phrase(exception,[E|Es]) }.
*/
%/*
log_lines(error([E|Es])) -->
        lsb
          ,lp
            ,star, error, [E|Es], { phrase(star,[E|Es]) }.
%*/

log_lines(expected([E|Es])) -->
            expected, [E|Es], { phrase(star, [E|Es]) }.

log_lines(got([E|Es])) -->
            got, [E|Es], { phrase(star, [E|Es]) }.

log_lines(result([R|Rs],[E|Es])) -->
           [R|Rs], { phrase(result,[R|Rs]) }, [E|Es], { phrase(star, [E|Es]) }.

% I swear that's what this is called.
vagina_painting --> `[()]`.

% ===== Test log specific =====

error --> `Error`, whitespace.

error_hack --> `H-E-Fails`, whitespace.

expected --> `Expected`, colon.

got --> `Got`, colon.

result --> `Missed result`, colon.
result --> `Excessive result`, colon.

exception --> `Exception caught:`.


% ===== General parsing auxiliaries =====

% As in Kleene star
star --> [_], star.
star --> [].

% As [<expression>] in regexes.
optional(T) --> T.
optional(_T) --> [].


% Mainly used to skip whitespace.
whitespace --> sp, whitespace.
whitespace --> sp.
whitespace --> [].

sp --> ` `, !.
sp --> `\t`, !.
sp --> `\n`, !.

colon --> whitespace, `:`, !, whitespace.

% Brackets and parens

lp --> whitespace, `(`, !, whitespace.
rp --> whitespace, `)`, !, whitespace.

lsb --> whitespace, `[`, !, whitespace.
rsb --> whitespace, `]`, !, whitespace.

lcb --> whitespace, `{`, !, whitespace.
rcb --> whitespace, `}`, !, whitespace.

% Various operators
lt --> whitespace, `<`, !, whitespace.
gt --> whitespace, `>`, !, whitespace.
