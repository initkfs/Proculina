/**
@author initkfs
*/
:- module(info_about_questions, [
    
]).

:- use_module('culinary/info_about_cul_questions.pro').

info_aboutAbout(WordsList, ResultString):-
    info_about_cul_questions:infoAboutIngredient(WordsList, ResultString).
    
   