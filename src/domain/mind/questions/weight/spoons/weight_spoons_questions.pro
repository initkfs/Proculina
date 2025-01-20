/**
@author initkfs
*/
:- module(weight_spoons_questions, [
    
]).

:- use_module('./../../../../../core/core_services.pro').
:- use_module('./../com_weight_questions.pro').

:- use_module('speech/weight_spoon_speech.pro').
:- use_module('answers/weight_spoon_answer.pro').
:- use_module('measures/weight_spoon_measure.pro').

weightSpoonQuestion(WordsList, ResultString):-
    common_weight_questions:commonWeightQuestion(weight_spoon_speech:weightInSpoon, WordsList, weight_spoon_measure:вСтоловойЛожкеГрамм, _, РодПадеж, ВесГрамм),
    core_services:logDebug("Run weight in spoon command"),
    weight_spoon_answer:weightInSpoon(ResultString, ВесГрамм, РодПадеж);

    common_weight_questions:commonWeightQuestion(weight_spoon_speech:weightInTeaSpoon, WordsList, weight_spoon_measure:вЧайнойЛожкеГрамм, _, РодПадеж, ВесГрамм),
    core_services:logDebug("Run weight in tea spoon command"),
    weight_spoon_answer:weightInTeaSpoon(ResultString, ВесГрамм, РодПадеж).
    
    % phrase(weight_spoon_speech:weightInSpoonQuantity(X, КоличествоАтом), WordsList),
    % core_services:logDebug("Run weight in spoon quantity command"),
    % ingredients_controller:имПадежРодПадежДля(X, ИмПадеж, РодПадеж),
    % weight_spoon_measure:вСтоловойЛожкеГрамм(ИмПадеж, ВесГрамм),
    % quantity_controller:weightFromWordQuantity(КоличествоАтом, ВесГрамм, ВесИтог),
    % swritef(ResultString, "В %w столовых ложках %w грамм %w", [КоличествоАтом, ВесИтог, РодПадеж]);
    
    % phrase(weight_spoon_speech:weightInTeaSpoonQuantity(X, КоличествоАтом), WordsList),
    % core_services:logDebug("Run weight in tea spoon quantity command"),
    % ingredients_controller:имПадежРодПадежДля(X, ИмПадеж, РодПадеж),
    % weight_spoon_measure:вЧайнойЛожкеГрамм(ИмПадеж, ВесГрамм),
    % quantity_controller:weightFromWordQuantity(КоличествоАтом, ВесГрамм, ВесИтог),
    % swritef(ResultString, "В %w чайных ложках %w грамм %w", [КоличествоАтом, ВесИтог, РодПадеж]).