/**
@author initkfs
*/
:- module(info_culinary_questions, [
    
]).

:- use_module('./../../../../core/core_services.pro').

:- use_module('speech/info_culinary_speech.pro').
:- use_module('answers/info_culinary_answer.pro').
:- use_module('reports/info_culinary_report.pro').
:- use_module('db/info_culinary.pro').


infoAboutTheme(WordsList, ResultString):-
    phrase(info_culinary_speech:infoAboutTheme(ИмПадежТема), WordsList),
    info_culinary:имПадежВпредлПадеж(ИмПадежТема, ИмПадеж, ПредлПадеж),
    core_services:logDebug("Run culinary info command"),
    info_culinary_report:infoAboutAll(ИмПадеж, ResultReport),
    info_culinary_answer:answerAboutTheme(ResultString, ПредлПадеж, ResultReport).