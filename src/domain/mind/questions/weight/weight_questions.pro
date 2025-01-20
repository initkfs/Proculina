/**
@author initkfs
*/
:- module(weight_questions, [
    
]).

:- use_module('spoons/weight_spoons_questions.pro').
:- use_module('glasses/weight_glass_questions.pro').

weightQuestion(WordsList, ResultString):-
    weight_spoons_questions:weightSpoonQuestion(WordsList, ResultString);
    weight_glass_questions:weightGlassQuestion(WordsList, ResultString).
    
   