/** <module> Main command interpreter
@author initkfs
*/
:- module(incoming, [
   parseCommand/3
]).

:- use_module(library(dcg/basics)).
:- use_module(library(pcre)).

:- use_module('./../../core/core_services.pro').
:- use_module('./../../core/utils/collection_util.pro').

:- use_module('db/ingredients.pro').
:- use_module('controllers/quantity_controller.pro').

:- use_module('speech/interact.pro').
:- use_module('speech/weight.pro').

parseCommand(_, WordsList, ResultString):-
    phrase(weight:weightInSpoon(X), WordsList),
    core_services:logDebug("Run weight in spoon command"),
    импадеж(X, ИмПадеж),
    родпадеж(ИмПадеж, РодПадеж),
    вСтоловойЛожкеГрамм(ИмПадеж, ВесГрамм),
    swritef(ResultString, "В столовой ложке %w грамм %w", [ВесГрамм, РодПадеж]);

    phrase(weight:weightInSpoonInc(X), WordsList),
    core_services:logDebug("Run increased weight in spoon command"),
    импадеж(X, ИмПадеж),
    родпадеж(ИмПадеж, РодПадеж),
    вСтоловойЛожкеГраммГорка(ИмПадеж, ВесГрамм),
    swritef(ResultString, "В столовой ложке с горкой %w грамм %w", [ВесГрамм, РодПадеж]);

    phrase(weight:weightInSpoonQuantity(X, КоличествоАтом), WordsList),
    core_services:logDebug("Run weight in spoon quantity command"),
    импадеж(X, ИмПадеж),
    родпадеж(ИмПадеж, РодПадеж),
    вСтоловойЛожкеГрамм(ИмПадеж, ВесГрамм),
    quantity_controller:wordToQuantity(КоличествоАтом, КоличествоЧислоАтом),
    ВесИтог is КоличествоЧислоАтом * ВесГрамм,
    swritef(ResultString, "В %w столовых ложках %w грамм %w", [КоличествоАтом, ВесИтог, РодПадеж]);

    phrase(interact:questionNotCorrect, AnswerList),
    atomic_list_concat(AnswerList, " ", ResultString).
