:-module(test_harness, [generate_answers/3
                       ,new_file_extension/4
                       ,renamed_file/3
                       ,deleted_file/2
                       ]).

/** <module> Run metta test scripts and generate answers files.

This module implements a rudimentary test harness for metta tests.
Predicates defined here execute metta test scripts and write out files
containing their outputs.

We refer to files with test script outputs as answer files. Predicates
in this module run test scripts and write out answers files. Tests are
mainly run with a timeout (via the linux timeout command) and so the
main way that a test will fail is by timing out.

Some high-level information about predicates exported by this module:

generate_answers/2
------------------

Runs metta tests in a directory and generates answers files, including
for timed-out and otherwise error'd tests. Takes a timeout parameter.

Example call:
==
?- _Dir='test-suite/nars_w_comp/nars/main-branch', generate_answers(run,_Dir,1).
==

The query above will run all tests in _Dir with a timeout of 1 second
(passed to the shell timeout command) and write out answers files, with
the extension ".metta.answers". The first argument, "run" indicates
that files will be written normally; alternatively, if the same query is
made with "dry_run" as the first argument, no files will be written.

*/

% Set and reset top-level logging for each known debug subject.
%
% Uncomment only first directive to turn off logging
% Uncomment each other directive to turn on logging for the
% corresponding subject.
:-nodebug(_).
:-debug(run_timed_out).
:-debug(deleted_file).
:-debug(run_tests).
:-debug(exec_command).
:-debug(was_answers_file_written).
:-debug(shell_code_action).
:-debug(renamed_file).


%!      clobber(?Bool) is semidet.
%
%       Whether to clobber existing answers files or not.
%
%       If Bool is true, tests for metta files with an existing answers
%       are not run at all.
%
clobber(false).


%!      test_file_extension(?Extension) is semidet.
%
%       Filename Extension of metta test files.
%
%       This will normally be ".metta", although Extension should just
%       be the part after the '.'.
%
test_file_extension(metta).


%!      answers_file_extension(?Extension) is semidet.
%
%       Filename Extension of metta test answers files.
%
%       This will normally be ".answers", although Extension should just
%       be the part after the '.'.
%
answers_file_extension('metta.answers').


%!      metta_command(?Mode,?Cmd) is semidet.
%
%       The bash command to run the metta compiler.
%
%       Mode is an atom that describes the mode in which the command
%       should be run, currently one of: [run, dry_run]. Those are
%       interpreted as follows:
%       * Mode "run" runs the command normally and saves the output in
%         an answers file.
%       * Mode "dry_run" runs the command normally but does not
%         generate any answers files.
%
%       Cmd is a Prolog atom passed as the first argument to format/2 to
%       compose a command send to the Bourne shell. This atom can
%       contain all the special notation accepted by format/2, such as
%       ~w, ~n, ~f etc.
%
metta_command(run,
             'time -p timeout --foreground --k=5 --s=SIGKILL -v ~w metta "~w" > "~w" 2>&1').
% ~i ignores the argument in that position.
metta_command(dry_run,
             'time -p timeout --foreground --k=5 --s=SIGKILL -v ~w metta "~w" 2>&1 ~i').


%!      generate_answers(+Mode,+Directory,+Timeout) is det.
%
%       Generate test answers.
%
%       Mode is the mode in which to run the metta command, used to
%       select clauses of metta_command/2. Options are "run" and
%       "dry_run". See metta_command/2 for details.
%
%       Directory is the name of the directory in which test files are
%       to be found.
%
%       Timeout is the atomic timeout passed to the timeout command to
%       run the tests.
%
%       In Mode "run" this predicate will write answers files for all
%       executed tests. Existing files will be clobbered. In Mode
%       "dry_run", no files will be written, or replaced.
%
generate_answers(R,Dir,T):-
        test_file_extension(E),
        answers_file_extension(A),
        run_tests(R,Dir,T,E,A).



%!      run_tests(+Mode,+InFiles,+Timeout,+ExtIn,+ExtOut) is det.
%
%       Run the metta test scripts in a Directory.
%
%       Mode is the mode in which to run the metta command, used to
%       select clauses of metta_command/2. Options are "run" and
%       "dry_run". See metta_command/2 for details.
%
%       InFiles can be either an atomic directory name, or a list of
%       atomic absolute file paths. If InFiles is a directory name, it
%       is taken to be the name of the top-level directory to search for
%       .metta files with tests to be executed.
%
%       Timeout is an atom passed as the DURATION argument to the
%       timeout linux command. This may be a number, including a float,
%       in which case it will be interpreted as a duration in seconds,
%       the default. Otherwise a suffix 's' for seconds, 'm' for
%       minutes, 'h' for hours and 'd' for days can be appended to a
%       numeric value, but the whole argument must remain an atom. For
%       example '10m' is a valid argument, '0.5h' is a valid argument,
%       but 10h is not.
%
%       This predicate runs all the metta test scripts determined by
%       InFiles. If InFiles is a directory name this predicate runs all
%       test secripts in the given directory and all its subdirectories,
%       including over symbolic links (On Linux). In that case Metta
%       test scripts are identified as files with a '.metta' extension.
%
%       The result of running a script is a file with the same name as
%       the test script file, with the suffix '.answers' appended to
%       its file extension.
%
%       Test scripts are passed to metta via the timeout command using
%       the given Timeout value. The text of the command sent to the
%       bash shell is defined in metta_command/1. See that predicate for
%       more details.
%
run_tests(R,Dir,T,EIn,EOut):-
% When the first argument is a directory.
        atom(Dir),
        !,
        metta_command(R,Cmd),
        forall(directory_member(Dir,F,[recursive(true),
                                       extensions([EIn]),
                                       follow_links(true)
                                      ]),
                % Initial name of the file with test output.
               (new_file_extension(F,EIn,EOut,OF),
                exec_command(R,Cmd,T,F,OF)
                )
               ).
run_tests(R,Fs,T,EIn,EOut):-
% When the first argument is a list of file paths.
        is_list(Fs),
        metta_command(R,Cmd),
        forall(member(F,Fs),
               (new_file_extension(F,EIn,EOut,OF),
                exec_command(R,Cmd,T,F,OF)
                )
               ).


%!      exec_command(+Mode,+Command,+Timeout,+Test,+Answers) is det.
%
%       Execute a shell Command to run tests and generate answers files.
%
%       Mode is one of "run" and "dry_run". See metta_command/2 for
%       details.
%
%       Command is the command to be run, taken from the second argument
%       of metta_command/2.
%
%       Timeout is sent to the timeout shell command to run Command
%       with a timeout.
%
%       Test is the full atomic path of the metta test script to run
%       with Command.
%
%       Answers is the full atomic path of the answers file with the
%       output of running the script in Test with Command.
%
%       This is the business end of run_tests/4. Clauses of this
%       predicate are selected according to the value of clobber/1.
%
%       If clobber(false) is set and an answers file exists indicating
%       that a metta. test script has already been run, the test script
%       will not run and no new file will be generated.
%
%       If clobber(false) is not set then no check is made that an
%       answers file exists already and the test script is run again. In
%       that case, the existing file will be clobbered, i.e. its
%       contents completely replaced by the output of the new run of the
%       test script.
%
exec_command(_R,_Cmd,_T,_TF,AF):-
        clobber(false)
        ,debug(exec_command,'clobber(false). Looking for file ~w',[AF]),
        (   exists_file(AF)
        ->  debug(exec_command,'~w exists: Not running test',[AF])
        ;   debug(exec_command,'~w does not exist.',[AF]),
            fail
        ).
exec_command(_R,Cmd,T,TF,AF):-
        % C is the shell command with input and output file names.
        format(atom(C),Cmd,[T,TF,AF]),
        debug(exec_command,'Running test ~w',[TF]),
        shell(C,S),
        debug(exec_command,'Shell command exited with status ~w',[S]),
        was_answers_file_written(AF).


%!      was_answer_file_written(+AnswersFile) is det.
%
%       Check that an Answers file was written and report it.
%
%       Helper to log whether an answers file was written as a result of
%       attempgint to run a metta test script, or not.
%
was_answers_file_written(AF):-
        \+ exists_file(AF),
        !,
        debug(was_answers_file_written,'Answers file ~w was not written',[AF]).
was_answers_file_written(AF):-
        debug(was_answers_file_written,'Wrote answers file ~w',[AF]).


%!      new_file_extension(+Mode,+Filename,+ExtIn,+ExtOut,-New) is det.
%
%       Replace the extension of a filename with a new one.
%
%       Helper predicate to simplify changing filename extensions.
%
new_file_extension(F,EIn,EOut,F_):-
        file_name_extension(B,EIn,F)
        ,file_name_extension(B,EOut,F_).


%!      rename_file(+Mode,+InFile,+OutFile) is det.
%
%       Rename a file.
%
%       Wrapper around rename_file/2 to manage its behaviour according
%       to Mode.
%
%       The file to be renamed by this predicate must already exist (it
%       will normally be generated by generate_answers/5). If it doesn't
%       this predicate will only output a log message, but only if
%       renamed_file is being debugged, and exit without touching
%       the file system.
%
renamed_file(_,IF,_OF):-
        \+ exists_file(IF),
        !,
        debug(renamed_file,'Could not rename file ~w because it does not exist',[IF]).
renamed_file(run,IF,OF):-
        rename_file(IF,OF),
        debug(renamed_file,'Renamed answers file to ~w',[OF]).
renamed_file(dry_run,_IF,OF):-
        debug(renamed_file,'Renamed answers file to ~w',[OF]).


%!      deleted_file(+Mode,+File) is det.
%
%       Delete a File.
%
%       Wrapper around delete_file/1 to manage its behaviour according
%       to Mode.
%
deleted_file(_,IF):-
        \+ exists_file(IF),
        !,
        debug(deleted_file,'Could not delete file ~w because it does not exist',[IF]).
deleted_file(run,F):-
        delete_file(F),
        debug(deleted_file,'Deleting file ~w',[F]).
deleted_file(dry_run,F):-
        debug(deleted_file,'Deleting file ~w',[F]).
