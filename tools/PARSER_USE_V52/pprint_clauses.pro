%database - pred_levels
%pred_level( integer, EXPR )





database - tmpx
determ count( integer )


predicates


filter_transpiled_numbers( ATOM_LIST, ilist, ilist, ATOM_LIST ) - ( i, o, o, o )
increment( integer ) - ( o )

transpile_claus( integer, OPERATOR, ATOM_LIST , string ) - ( i, i, i , o )



transp_ato( integer, ATOM, string ) - ( i, i, o )

transp_ato_list( integer, ATOM_LIST , string, string ) - ( i, i, i, o )
 



%display_predicate_levels()
% pprint( EXPR , integer ) - ( i , i )
 increment_count( integer ) - ( o )
 
 % pprint_atom_list( ATOM_LIST , integer , integer ) - ( i , i , o )
%does_have_nesting2( ATOM_LIST , integer ) - ( i , o  )
 %does_have_nesting( EXPR , integer ) - ( i , o  )
%does_have_nesting( ATOM_LIST , integer ) - ( i , o  )

write_nspaces( integer ) - ( i ) 
 
% replace_interpreted_functions(  ATOM_LIST , ATOM_LIST ) - ( i,o)

length_of_list( ATOM_LIST , integer, integer ) - ( i,i,o)

write_level( integer ) - ( i )


str_before( string, string, string ) - ( i,i,o)




clauses


str_after( Varstr, Big_str, Before, Rest ):-
 str_len( Varstr , Lz ),  searchstring( Big_str , Varstr , Fp ), 
 Fpx = Fp - 1,
 frontstr( Fpx , Big_str , Before , _Rest0 ),
 Fp2 = Fp + Lz - 1, frontstr( Fp2 , Big_str , _Sta , Rest ), !.

str_before( Varstr, Jso_big_str, Sta ):-
% str_len( Varstr , Lz ),
 searchstring( Jso_big_str , Varstr , Fp ), 
 Fp2 = Fp - 1, frontstr( Fp2 , Jso_big_str , Sta , _Rest ), !.



length_of_list( [_|Lis0x ] , C, Le ):- C2 = C + 1, length_of_list( Lis0x  , C2, Le ).
length_of_list( [] , Le, Le ):-!.

increment_count( C2 ) :- retract( count( C) ),!, C2 = C + 1, assert( count( C2 ) ).

% sumlist( [] , 0 ).
% sumlist( [ H | T ] , R ):-
%  sumlist( T , R1 ) ,
%  R is H + R1 .

%  Figure 6.3  A procedure for substituting a subterm of a term by another subterm.
%--- substitute( Subterm, Term, Subterm1, Term1):
%    if all occurrences of Subterm in Term are substituted
%    with Subterm1 then we get Term1.
% Case 1: Substitute whole term
%substitute( Term, Term, Term1, Term1 )  :-  !.
% Case 2: Nothing to substitute
%substitute( _ , Term , _ , Term )  :-    atomic( Term ), !.
% Case 3: Do substitution on arguments
%substitute( Sub, Term, Sub1, Term1 )  :-
%   Term  =..  [ F | Args ],                        % Get arguments
%   substlist( Sub, Args, Sub1, Args1 ),         % Perform substitution on them
%   Term1  =..  [ F | Args1 ].		       % Construct Term1
%substlist( _, [], _, [] ).
%substlist( Sub, [ Term | Terms ], Sub1, [ Term1 | Terms1 ])  :-
%   substitute( Sub, Term, Sub1, Term1 ),
%   substlist( Sub, Terms, Sub1, Terms1 ).


  

%---
%does_have_nesting2( [ metta_sub( _ ) | _ ], 1 ):- !.
%does_have_nesting2( [ _ | Rest ], Rs ):-  does_have_nesting2( Rest , Rs ) , !.

%does_have_nesting( Lis , Res ):- does_have_nesting2( Lis, Res ), ! .
%does_have_nesting( _ , 0 ):- !.

%---
write_nspaces( N ):- N > 0, !, write( "  " ),  N2 = N - 1, write_nspaces( N2 ).
write_nspaces( _N ):-  !.
 
 
%  par_atom_list
% metta_sub( par_atom_list
%  par_atom_list( equal,  [  metta_sub( par_atom_list(namex(  
% par_atom_list(namex("simple_deduction_strength_formula"),[variabel("

%par_atom_list(equal,
% [metta_sub(par_atom_list(
%  namex("simple_deduction_strength_formula"),  [variabel("$As"),variabel("$Bs"),
%    variabel("$Cs"),variabel("$ABs"),variabel("$BCs")]
%	)),
%  metta_sub( par_atom_list(conditional,
%	 [metta_sub( par_atom_list(conjuction,
%	  [metta_sub( par_atom_list( namex( "conditional_probability_consistency"),
%	  [variabel("$As"),variabel("$Bs"),variabel("$ABs")])),
%	  metta_sub(par_atom_list(namex("conditional_probability_consistency"),
%	  [variabel("$Bs"),variabel("$Cs"),variabel("$BCs")]))])),
%	  metta_sub(par_atom_list(conditional, [ metta_sub( par_atom_list ( 
%	   smallerthan, [number(0.99),variabel("$Bs")])),
%	    variabel("$Cs"), metta_sub( par_atom_list( plus, 
%	[metta_sub( par_atom_list(
%		 multiplication, [ variabel("$ABs"),variabel("$BCs")])),
%		 metta_sub(par_atom_list(division,[ 
%		  metta_sub( par_atom_list( multiplication,
%		  [metta_sub( par_atom_list( minus, [ number(1), variabel("$ABs")])),
%		  metta_sub( par_atom_list(minus, [variabel("$Cs"), metta_sub( par_atom_list(
%		  multiplication, [variabel("$Bs"), variabel("$BCs")]))]))])),
%		 metta_sub(par_atom_list(minus,[number(1),variabel("$Bs")]))]))
%  ]))])),number(0)]))
% ])
% does_have_nesting( Lis , Res )
%transpile_metta_clause_to_prolog( Operatorx, Lis, Prolog_text ):-
% term_str( OPERATOR, Operatorx, Sx ),
% term_str( ATOM_LIST, Lis, Hsx ), concat( Sx, Hsx, C1 ), concat( "\nfinal_term", C1, Prolog_text ).
%---
%transpile_metta_to_prolog( Operator, Lis , Hs, Transpiled_text ):-
% does_have_nesting( Lis , Res ), Res = 0 , !, 
% transpile_metta_clause_to_prolog( Operator, Lis, Prolog_text ), 
% concat( Hs, Prolog_text, Transpiled_text ).

write_level( Level ):- str_int( Sx, Level), write( "\n-lev-", Sx , "- " ), !.



%----


%has_sub_nesting2( _, [] ) :- !.
%has_sub_nesting2( [ metta_sub( _S_expr ) | _Lis ] , 1 ):- !.
   %   transpile_metta_to_prolog( Level2, S_expr ), write( ")" ), transpile_metta_to_prolog2( Level, Lis ).
has_no_sub_nesting2( [] , Res, Res ):-!.

has_no_sub_nesting2( [ metta_sub(  par_atom_list( _Operatorx , Ato_lis ) ) | _Lis ] , Cou,  Res ):- !, Cou2 = Cou + 1,
    has_no_sub_nesting2(  Ato_lis  , Cou2, Res ), !.
has_no_sub_nesting2( [ _H | Lis ] , Cou, Res ):- !,   has_no_sub_nesting2( Lis  , Cou, Res ),!.

% has_sub_nesting2( [ _ | Lis ] , Res ):- !,     has_sub_nesting2(  Lis  , Res ),!.

%  has_sub_nesting2( Ato_List, Res ).
% has_sub_nesting2( [ _H | Lis ] , Res ):- !,    has_sub_nesting2( Lis, Res ).


%has_sub_nesting3( Lis , Res ):- !,    has_sub_nesting2( Lis, Res ).
%has_sub_nesting3( Lis , 0 ):- !.

%----
%has_no_sub_nesting( S_expr ):-  has_sub_nesting( S_expr , Res ), Res = 1, !, fail.
%has_no_sub_nesting( _S_expr ):- !.

%-----
%transpile_metta_to_prolog( _ ):- !.
%has_sub_nesting( par_atom_list( _Operatorx , Atom_List ) , Res ):-   has_sub_nesting2( Atom_List, Res ), !.
%has_sub_nesting( par_atom_list( _Operatorx , Atom_List ) , 0 ):- !.

%has_sub_nesting( exclama_atom_list( _Operatorx , Atom_List ) , Res ):-     has_sub_nesting2( Atom_List , Res ), !.
%has_sub_nesting( exclama_atom_list( _Operatorx , _Atom_List ) , 0 ):- !.
%---


%----

write_out_metta2( _ , [] ) :- !.
write_out_metta2( Level, [ metta_sub( S_expr ) | Lis ] ):- !,   Level2 = Level + 1, write( "(" ), 
   write_out_metta( Level2, S_expr ), write( ")" ), write_out_metta2( Level, Lis ).
write_out_metta2( Level, [ H | Lis ] ):- !, term_str( ATOM, H, Sx ),
   write_level( Level ),   write( Sx , "\n" ) , write_out_metta2( Level, Lis ).

%-----
write_out_metta( Level, par_atom_list( Operatorx , Atom_List ) ):-
  term_str( Operator, Operatorx, Sx ), write_level( Level ),
  concat( "par_atox ", Sx, C1 ), write( C1 ),   write_out_metta2( Level, Atom_List ).
write_out_metta( Level, exclama_atom_list( Operatorx , Atom_List ) ):- 
  term_str( Operator, Operatorx, Sx ), write_level( Level ), concat( "exclamax ", Sx, C1 ), write( C1 ), 
  write_out_metta2( Level, Atom_List ).
%---


%--**********


%  Figure 6.3  A procedure for substituting a subterm of a term by another subterm.
%--- substitute( Subterm, Term, Subterm1, Term1):
%    if all occurrences of Subterm in Term are substituted
%    with Subterm1 then we get Term1.
% Case 1: Substitute whole term
%substitute( Term, Term, Term1, Term1 )  :-  !.
% Case 2: Nothing to substitute

%substitute( _ , Term , _ , Term )  :-    atomic( Term ), !.
% Case 3: Do substitution on arguments
%substitute( Sub, Term, Sub1, Term1 )  :-
%   Term  =..  [ F | Args ],                        % Get arguments
%   substlist( Sub, Args, Sub1, Args1 ),         % Perform substitution on them
%   Term1  =..  [ F | Args1 ].		       % Construct Term1
%substlist( _, [], _, [] ).
%substlist( Sub, [ Term | Terms ], Sub1, [ Term1 | Terms1 ])  :-
%   substitute( Sub, Term, Sub1, Term1 ),
%   substlist( Sub, Terms, Sub1, Terms1 ).


%----


% transpile_metta2( [ metta_sub( S_expr ) | Lis ] , [ metta_sub( S_expr2 ) | Result_list ] ):- 
  %transpile_metta2( [ metta_sub( S_expr ) | Lis ] , [ namex( S_expr2 ) | Result_list ] ):- 
  %has_no_sub_nesting( S_expr ),    
  %S_expr = par_atom_list( Operat, Ato_lis ), !,
  %term_str( OPERATOR , Operat, Sx0 ),
  %term_str( ATOM_LIST , Ato_lis, Sx ), concat( "transpclaus ", Sx0, C1 ), concat( C1, Sx, Sx2 ),
  % transpile_claus( S_expr, S_expr2 ),     !,   
  %transpile_metta( S_expr , S_expr2 ),  !, 
% has_no_sub_nesting( S_expr ),    


% VARIANT 
%transpile_metta2( [ metta_sub( Atom_List2 ) | Lis ] , Result_list  ):- 
%    has_no_sub_nesting( Atom_List2 ), !,
%    term_str( EXPR , Atom_List2, Sx ),    concat( "transpzclaus ", Sx, C1 ), 
%  transpile_metta2(  [ namex( C1 ) | Lis ], Result_list ).


%substitute( _ , Term , _ , Term )  :-    atomic( Term ), !.
% Case 3: Do substitution on arguments
%substitute( Sub, Term, Sub1, Term1 )  :-
%   Term  =..  [ F | Args ],                        % Get arguments
%   substlist( Sub, Args, Sub1, Args1 ),         % Perform substitution on them
%   Term1  =..  [ F | Args1 ].		       % Construct Term1
%substlist( _, [], _, [] ).
%substlist( Sub, [ Term | Terms ], Sub1, [ Term1 | Terms1 ])  :-
%   substitute( Sub, Term, Sub1, Term1 ),
%   substlist( Sub, Terms, Sub1, Terms1 ).


 % has_no_sub_nesting( Atom_List2 ), !,
 %has_no_sub_nesting2(  Atom_List2  , 0, Res ), 
 % Res = 0, !,
 %term_str( ATOM_LIST , Atom_List2, Sx ),  
 %	 format( Qw, "% %", Sx, Res ), dlg_Note( "subnest", Qw ), 	
 %Res = 0, !,
%concat( "transpzclaus ", Sx, C1 ), 

%transp_operat( namex( S ) , Qw ):- !, format( Qw, "namex( % )", S ).
%transp_operat( namex( S ) , Qw ):- !, format( Qw, "namex( \"%\" )", S ).
transp_operat( namex( S ) , S ):- !.
transp_operat( variabel( S ) , Qw ):- !, format( Qw, "variabel( \"%\" )", S ).
transp_operat( Ato , Qw ):- !, term_str( OPERATOR, Ato, QW ), !.

% transp_ato( namex( S ) , Qw ):- !, format( Qw, "namex( \"%\" )", S ).
transp_ato( _, namex( S ) , S ):- !.

transp_ato( is_debug, variabel( S ) , S3 ):- !, upper_lower( S2, S ) , string_replace_tag( S2, "$", "", S3 ).

transp_ato( is_debug, number( Va ) , S3 ):- !, str_real( S3, Va ).

transp_ato( _, variabel( S ) , Qw ):- !, format( Qw, "variabel( \"%\" )", S ).
% transp_ato( is_debug, transpiled(  Nx, S ) , Qw ):- !, format( Qw, " ##  % ", S ).

% is_transp(44,5,namex("conditional_probability_consistency"),[],[variabel("$Bs"),variabel("$Cs"),variabel("$BCs")])
% is_transp(44,21,conditional,[8,20],[transpiled(8,""),variabel("$Cs"),transpiled(20,"")])

transp_ato( is_debug, transpiled( Nx, S ) , Qw ):- 
 is_transp( 44 , Nx, Operat , _Sublist , Ato_lis, _ ) ,
 term_str( ATOM_LIST, Ato_lis, Q0 ),
 !, format( Qw, "transx(- % , % -)", Nx, Q0 ).

transp_ato( is_debug, transpiled( Nx, S ) , Qw ):- !, format( Qw, "transx( % , % )", Nx, S ).

transp_ato( _, Ato , Qw ):- !, term_str( ATOM, Ato, QW ), !.

transp_ato_list( _, [] , Resu_str, Resu_str ):- !.
transp_ato_list( Is_perform, [ Ato ] , Hs, C1 ):- !,
  transp_ato( Is_perform, Ato, Sx ), concat( Hs, Sx, C1 ).
transp_ato_list( Is_perform, [ Ato | Rest ] , Hs, List_str ):-
  transp_ato( Is_perform, Ato, Sx ), concat( Hs, Sx, C1 ), concat( C1, " , ", C2 ),
  transp_ato_list(  Is_perform, Rest  , C2, List_str ).



transpile_claus( Is_perform,  Operat , Ato_List , Sx2 ):- Is_perform = is_debug, !,
  transp_operat( Operat , Op_s ),
  transp_ato_list( Is_perform, Ato_List , "", List_str ),
  concat( Op_s, "( ", C1 ),  concat( C1, List_str, Sx ), concat( Sx, " ) ", Sx2 ).


transpile_claus( Is_perform,  Operat , Ato_List , Sx2 ):- Is_perform = is_perform, !,
  transp_operat( Operat , Op_s ),
  transp_ato_list( Is_perform, Ato_List , "", List_str ),
  concat( Op_s, "( ", C1 ),  concat( C1, List_str, Sx ), concat( Sx, " ) ", Sx2 ).
 

transpile_claus( Is_perform,  Operat , Ato_List , Sx2 ):- !,
  transp_operat( Operat , Op_s ),
  transp_ato_list( Is_perform, Ato_List , "", List_str ),
  concat( Op_s, "( [ ", C1 ),  concat( C1, List_str, Sx ), concat( Sx, " ] ) ", Sx2 ).
  
  % term_str( ATOM_LIST , Ato_List, Sx ), concat( "transpclaus ", Sx, Sx2 ).


%transpile_claus( exclama_atom_list( Operatorx , Ato_List ), exclama_atom_list( Operatorx , [ namex( Sx2 ) ] ) ):- !,
%    term_str( ATOM_LIST , Ato_List, Sx ), concat( "transpexclam ", Sx, Sx2 ).	

increment( C2 ):- retract( tel( C ) ), !, C2 = C + 1, assert( tel( C2 ) ).

%---
% i,o,o
filter_transpiled_numbers( [],  []  , [], [] ):- !.

filter_transpiled_numbers( [ transpiled( Tnum,  _ ) | Rs ],   [ Tnum | Nums ]  ,  Transp_numbers,  [ numf( Tnum ) | Newlis ] ):- !,
 filter_transpiled_numbers(  Rs ,   Nums  , Transp_numbers, Newlis ).

filter_transpiled_numbers( [ H | Rs ],   Nums  , [ 0 | Transp_numbers ] , [ H | Newlis ] ):- !,
 filter_transpiled_numbers(  Rs ,   Nums  , Transp_numbers, Newlis ).
%----



transpile_metta2( _, _, _, _, _,  [] , [] ) :- !.


transpile_metta2( Level, Levelsub, Level_inside, Is_perform,  Cou, [ metta_sub( par_atom_list( Operat, Atom_List2 ) ) | Lis ] , [ transpiled( Count, Sx ) | Result_list ] ):- 
     increment( Count ),
	 has_no_sub_nesting2(  Atom_List2  , 0, Res ), 
	 transpile_claus( Is_perform, Operat , Atom_List2 , Sx ),
	 Res = 0 , !,
	 filter_transpiled_numbers( Atom_List2, Transp_numbers, _Nils, Atom_List3 ), 
	 % todo filter also transpiled cases itself
	 assert( is_transp( Is_perform, Count, Operat, Transp_numbers, Atom_List3, Atom_List2 ) ),
     Level2 = Level +  0, 
	 Levelsub2 = Levelsub + 1,
	 transpile_metta2( Level2, Levelsub2, Level_inside, Is_perform, Cou, Lis, Result_list ).

transpile_metta2( Level, Levelsub, Level_inside , Is_perform, Cou, [ metta_sub( par_atom_list( _Op, Atom_List2) ) | Lis ] , Result_list  ):-  !,
    Level_inside2 = Level_inside + 1,
	Level2 = Level + 1 , 
	Levelsub2 = Levelsub + 0,
	transpile_metta2( Level2, Levelsub2, Level_inside2 , Is_perform, Cou, Atom_List2, Atom_List3 ),
    
	transpile_metta2( Level2, Levelsub2, Level_inside , Is_perform,  Cou,  [ metta_sub( par_atom_list( _Op, Atom_List3) ) | Lis ], Result_list ).

transpile_metta2( Level, Levelsub, Level_inside , Is_perform, Cou, [ H | Lis ] , [ H | Result_list ] ):-       
    Level2 = Level + 1 , 
	Levelsub2 = Levelsub + 0 ,
	transpile_metta2( Level2, Levelsub2, Level_inside , Is_perform, Cou, Lis, Result_list ).


% todo transp operator 
%transpile_metta( par_atom_list( Operatorx , Atom_List ), par_atom_list( Operatorx , Atom_List ) ):-     has_sub_nesting3( Atom_List , Res4 ), Res4 = 0, !.
    
transpile_metta( Is_perform, par_atom_list( Opx , Atom_List ), par_atom_list( Opx , Atom_List ) ):-   
  has_no_sub_nesting2( Atom_List , 0, Res ), Res = 0, !.

transpile_metta( Is_perform, par_atom_list( Opx , Atom_List ), par_atom_list( Opx , Atom_List2 ) ):-   
  %Atom_List = [ H | Rest ],
  %transpile_metta2( Rest , Rest2 ) , 
  %Atom_List2 = [ H | Rest2 ].
  transpile_metta2( 0, 0, 0, Is_perform , 0, Atom_List , Atom_List2 ) .
  
  %transpile_metta2(  Atom_List ,   Atom_List2  ),  
  %has_sub_nesting3( Atom_List2 , Res ), Res = 1, !,
  %transpile_metta( par_atom_list( Operatorx , Atom_List2 ), Result ).
  
%transpile_metta( par_atom_list( Operatorx , Atom_List ), par_atom_list( Operatorx , Atom_List2 ) ):- !.  
  
%transpile_metta( exclama_atom_list( Operatorx , Atom_List ) , par_atom_list( Operatorx , Atom_List2 )  ):-  
%  transpile_metta2( Atom_List ,   Atom_List2 ).


%--- 
% transpile_metta_to_prolog( Lis , Hs, Transpiled_text1 ),
%term_str( OPERATOR, Operatorx, Sx ),
%term_str( ATOM, H, Hsx ), concat( Sx, Hsx, C1 ), concat( Hs, C1, Hs2 ),
%transpile_metta_to_prolog( namex( Sx ), Lis ).



   
% pprint_atom_list( [] , Count, Count ):- !.

% pprint_atom_list( [ metta_sub( SEXPR ) ] , N, Result_count ):-  !,  write( "\n"), write_nspaces( N ), write("metta_sub("  ), 
%   does_have_nesting( SEXPR, Result ), 
%   assert( pred_level( N, Result, SEXPR ) ),
%   pprint( SEXPR , N, Result_count ), write( ") " ).

% pprint_atom_list( [ metta_sub( SEXPR ) | Lis ] , N, Cou_x ):-  !, write_nspaces( N ), write( "\n"), write_nspaces( N ), write( "metta_sub("  ), 
%   pprint( SEXPR, N, Result_count ), write( " ), " ), 
%   N2 = Result_count + 1,
%   does_have_nesting( SEXPR, Result ), 
%   assert( pred_level( N, Result, SEXPR ) ),
%   pprint_atom_list( Lis , N2 , Cou_x ).

% pprint_atom_list( [ variabel( Var ) ] , Nx, Nx ):-  !, write( " var(" , Var, ") " ).
% pprint_atom_list( [ variabel( Var ) | Lis ] , N , Cou ):-  !, write( " var(" , Var, "), " ),   pprint_atom_list( Lis , N, Cou ).

% pprint( par_atom_list( _Op, Lis ) , N, Result_count  ):-  write( "\n"), write_nspaces( N ),  write( "par_atom_list( [ " ),  pprint_atom_list( Lis, N , Result_count ), write(" ] ) "), !.
% pprint( _ , N, N ):- !.	    

%  term_str( ATOM_LIST, Lis0x, Sx1 ), format(Yq, "% %", Le, Sx1 ), dlg_Note( "aa1", Yq ),
%     dlg_Note( "aa2", Head_token ),

%---
%replace_interpreted_functions( [], [] ) :- !.
%replace_interpreted_functions( [ metta_sub( par_atom_list( Lis0x ) ) | Lis ], [ variabel( Name ) | Lis2 ] ) :-   
%     Lis0x = [ variabel( Head_token) | Restlist ] ,  
%     length_of_list( Restlist , 0, Le ), 
%     predicate_interpreted( Le, Head_token, Name, _ ), !,
%   replace_interpreted_functions(  Lis ,  Lis2  ).
%replace_interpreted_functions( [ metta_sub( par_atom_list( Lis0x ) ) | Lis ], [ metta_sub( par_atom_list( Lis0x2 ) ) | Lis2 ] ) :-   
%    replace_interpreted_functions(  Lis0x  , Lis0x2 ), !,
%   replace_interpreted_functions(  Lis ,  Lis2  ).
% replace_interpreted_functions( [ H | Lis ], [ H | Lis2 ] ) :- replace_interpreted_functions(  Lis ,  Lis2  ) .

%----
%asser_predicate_interpreted( Le, Head_token, _Name, _SEXPR ) :-
%   predicate_interpreted( Le, Head_token, _, _ ) , !.

%asser_predicate_interpreted( Le, Head_token, Name, SEXPR ):-
%   assert( predicate_interpreted( Le, Head_token, Name, SEXPR ) ), !.



%----
%interpret_predicate_levels( Functs_count, par_atom_list( _,  []  )):-  retractall( count( _ ) ), assert( count( Functs_count ) ),
%   retractall( predicate_interpreted( _, _, _, _ ) ),
%   pred_level( N, Has_nesting, SEXPR ),     Has_nesting = 0,
%   SEXPR = par_atom_list( _, [ variabel( Head_token) | Lis ] ), length_of_list( Lis , 0, Le ), str_int( Le_s, Le ),
%   increment_count( Count ), str_int( Counts, Count ),
%   concat( "funct_", Counts, Name ),
%   asser_predicate_interpreted( Le, Head_token, Name, SEXPR ) ,
%   term_str( EXPR, SEXPR, Sx ),  write( "\n" ), write( Le_s , " " ), write( Head_token, " ", Name, " ", Sx, " " ),    fail , !.
%interpret_predicate_levels( Fc , par_atom_list( _,  Lis2  ) ):-
%  pred_level( N, Has_nesting, SEXPR ),   Has_nesting = 1,
%  N = 0,
%  write("\first run\n"),
%  format( Labelx, "original clause at level : % ", Fc ),
%  term_str( EXPR, SEXPR, Sx0 ),   write( "\n ", Labelx,  Sx0 ),  
%  SEXPR = par_atom_list(  _, Lis  ),
%  replace_interpreted_functions(  Lis, Lis2 ), !.
%interpret_predicate_levels( _Fc, par_atom_list( _, [] ) ):- !.
  