/**
@author initkfs
*/
:- module(info_ingredients_questions, [
    
]).

:- use_module('./../../../../core/core_services.pro').

:- use_module('./../../ingredients/speech/ingredients_case.pro').
:- use_module('speech/info_ingredients_speech.pro').
:- use_module('answers/info_ingredients_answer.pro').
:- use_module('reports/info_ingredients_report.pro').


infoAboutIngredient(WordsList, ResultString):-
    phrase(info_ingredients_speech:infoAboutIngredient(ИмПадеж), WordsList),
    ingredients_case:имПадежВпредлПадеж(Ingredient, ИмПадеж, ПредлПадеж),
    core_services:logDebug("Run info command"),
    info_ingredients_report:infoAboutAll(ИмПадеж, ResultReport),
    info_ingredients_answer:infoAboutIngredient(ResultString, ПредлПадеж, ResultReport).