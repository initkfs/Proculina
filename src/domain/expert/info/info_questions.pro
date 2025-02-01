/**
@author initkfs
*/
:- module(info_questions, [
    
]).

:- use_module('ingredients/info_ingredients_questions.pro').

infoAbout(WordsList, ResultString):-
    info_ingredients_questions:infoAboutIngredient(WordsList, ResultString).
    
   