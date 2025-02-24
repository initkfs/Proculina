/**
@author initkfs
*/
:- module(info_questions, [
    
]).

:- use_module('ingredients/info_ingredients_questions.pro').
:- use_module('culinary/info_culinary_questions.pro').

infoAbout(WordsList, ResultString):-
    info_ingredients_questions:infoAboutIngredient(WordsList, ResultString);
    info_culinary_questions:infoAboutTheme(WordsList, ResultString).

continueAboutCulinary(WordsList, ThemeName, ThemeIndex, ResultString):-
    info_culinary_questions:continueAboutTheme(WordsList, ThemeName, ThemeIndex, ResultString).
     
   