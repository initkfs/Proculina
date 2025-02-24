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
:- use_module('./../com_info_question.pro').


infoAboutTheme(WordsList, ResultString):-
    phrase(info_culinary_speech:infoAboutTheme(Тема), WordsList),
    info_culinary:имПадежВпредлПадеж(Тема, ИмПадеж, ПредлПадеж),
    core_services:logDebug("Run culinary info command"),
    info_culinary_report:infoAboutAll(ИмПадеж, ResultReportList),
    saveThemeOrAnswer(ResultReportList, ResultString, ИмПадеж, ПредлПадеж).

saveThemeOrAnswer(ResultReportList, ResultString, ИмПадежТема, ПредлПадеж):-
    com_info_question:checkCurrentTheme(ИмПадежТема, ResultReportList, NextListItem), 
    info_culinary_answer:answerAboutThemeShort(ResultString, ИмПадежТема, ПредлПадеж, [NextListItem]);
    info_culinary_answer:answerAboutTheme(ResultString, ИмПадежТема, ПредлПадеж, ResultReportList).