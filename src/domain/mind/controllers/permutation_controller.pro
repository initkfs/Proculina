/**
@author initkfs
*/
:- module(permutation_controller, [
    writelnPerms/1
]).

:- use_module(library(lists)).

writelnPerms(InputString):-
   split_string(InputString, " ", "", StringList),
   setof(P, permutation(StringList, P), PermListsInList),
   writelnPerm(PermListsInList).

writelnPerm([]).
writelnPerm([H|T]) :-
    atomics_to_string(H, " ", String), 
    writeln(String), 
    writelnPerm(T).