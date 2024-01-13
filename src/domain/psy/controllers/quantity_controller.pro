/**
@author initkfs
*/
:- module(quantity_controller, [
    wordToQuantity/3,
    wordToQuantity/2,
    weightFromWordQuantity/3
]).

:- use_module('./../db/quantity.pro').

wordToQuantity(QuantityWord, QuantityNumber):-
    wordToQuantity(QuantityWord, QuantityNumber, количвоПадежМжРод).

wordToQuantity(QuantityWord, QuantityNumber, Goal):-
    findall([Num, List], (call(Goal, Num, List), memberchk(QuantityWord, List)), ResultList),
    length(ResultList, ListLen),
    ListLen > 0,
    nth0(0, ResultList, QuantityData),
    nth0(0, QuantityData, QuantityNumber).

weightFromWordQuantity(QuantityWord, WeightNumber, ResultWeightNumber):-
    wordToQuantity(QuantityWord, QuantityNumber),
    ResultWeightNumber is QuantityNumber * WeightNumber.