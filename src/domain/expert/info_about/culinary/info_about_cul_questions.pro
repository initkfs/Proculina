/**
@author initkfs
*/
:- module(info_about_cul_questions, [
    
]).

:- use_module('./../../../../core/core_services.pro').

:- use_module('./../../ingredients/speech/ingredients_case.pro').
:- use_module('speech/info_about_cul_speech.pro').
:- use_module('answers/info_about_cul_answer.pro').
:- use_module('reports/info_about_cul_report.pro').


infoAboutIngredient(WordsList, ResultString):-
    phrase(info_about_cul_speech:infoAboutIngredient(ИмПадеж), WordsList),
    ingredients_case:имПадежВпредлПадеж(Ingredient, ИмПадеж, ПредлПадеж),
    core_services:logDebug("Run info_about command"),
    info_about_cul_report:infoAboutAll(Ingredient, ResultReport),
    info_about_cul_answer:infoAboutIngredient(ResultString, ПредлПадеж, ResultReport).