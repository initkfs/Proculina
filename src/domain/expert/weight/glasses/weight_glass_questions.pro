/**
@author initkfs
*/
:- module(weight_glass_questions, [
    
]).

:- use_module('./../../../../core/core_services.pro').
:- use_module('./../com_weight_questions.pro').

:- use_module('answers/weight_glass_answer.pro').
:- use_module('speech/weight_glass_speech.pro').
:- use_module('answers/weight_glass_answer.pro').
:- use_module('measures/weight_glass_measure.pro').

weightGlassQuestion(WordsList, ResultString):-
    common_weight_questions:commonWeightQuestion(weight_glass_speech:weightInGlass, WordsList, weight_glass_measure:вСтаканеГрамм, _, РодПадеж, ВесГрамм),
    weight_glass_answer:weightInGlass(ResultString, ВесГрамм, РодПадеж).

    % commonWeightQuestion(weight_glass_speech:weightInGlass, WordsList, weight_glass_measure:вСтаканеГрамм, _, РодПадеж, ВесГрамм).
    % phrase(weight_glass_speech:weightInGlassQuantity(X, КоличествоАтом), WordsList),
    % core_services:logDebug("Run weight in glass quantity command"),
    % ingredients_case:имПадежРодПадежДля(X, ИмПадеж, РодПадеж),
    % weight_glass_measure:вСтаканеГрамм(ИмПадеж, ВесГрамм),
    % quantity_measure:weightFromWordQuantity(КоличествоАтом, ВесГрамм, ВесИтог),
    % swritef(ResultString, "В %w стаканах %w грамм %w", [КоличествоАтом, ВесИтог, РодПадеж]).