/**
@author initkfs
*/
:- module(collection_util, [
    toFlattenSet/2,
    stringSplitToList/2,
    biConvertListString/2
    ]).

:- use_module(library(error)).
% Don't remove the module, otherwise the exception stack will be lost
:- use_module(library(prolog_stack)).

toFlattenSet(InputList, OutSet):-
    not(is_list(InputList)),
    throw(error(type_error("List", InputList), context(_, _)));

    flatten(InputList, FlatList),
    list_to_set(FlatList, OutSet).

:- begin_tests(toFlattenSetTests).
:- use_module(library(debug)).
test(toFlattenSetTestThrowsIsNotList, [throws(error(_, _))]) :-
    toFlattenSet(1, _).
test(toFlattenSetTest) :-
    List = [1, [2, 3, 4], 5],
    toFlattenSet(List, OutSet),
    assertion(OutSet == [1, 2, 3, 4, 5]).   
:- end_tests(toFlattenSetTests).

%TODO strip
stringSplitToList(String, List):-
    string(String),
    split_string(String, ",", "", List);
    throw(error(instantiation_error, context(_, "No string found to convert to list"))).

:- begin_tests(stringSplitToList).
:- use_module(library(debug)).
test(stringSplitToListTest, [nondet]) :-
    String = " a,b,c, \n",
    stringSplitToList(String, List),
    assertion(List == [" a", "b", "c", " \n"]).   
:- end_tests(stringSplitToList).

biConvertListString(List, String):-
    string(String),
    is_list(List),
    throw(error(instantiation_error, context(_, "Unable to convert list and string, both arguments exist")));

    string(String),
    stringSplitToList(String, List);

    is_list(List),
    atomics_to_string(List, ',', String);

    format(string(ErrorMessage), "Unable to convert list and string, invalid types of both or one argument received, list: ~w, string: ~w", [List, String]),
    throw(error(instantiation_error, context(_, ErrorMessage))).

:- begin_tests(biConvertListStringList).
:- use_module(library(debug)).
test(biConvertListStringList, [nondet]) :-
    RawString = " a,b,c, \n",
    RawList = [" a", "b", "c", " \n"],
    biConvertListString(List, RawString),
    assertion(List == RawList),
    biConvertListString(RawList, String),
    assertion(String == RawString).
:- end_tests(biConvertListStringList).