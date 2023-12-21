/** <module> Main command interpreter
@author initkfs
*/
:- module(main_command_interpreter, [interpretCommand/2]).

:- use_module(library(dcg/basics)).
:- use_module(library(pcre)).

:- use_module('./../core/core_services.pro').
:- use_module('./../core/utils/collection_util.pro').
:- use_module('main_data_processor.pro').

:- use_module('db/ingredients.pro').
:- use_module('controllers/quantity_controller.pro').

:- use_module('speech/me.pro').
:- use_module('speech/weight.pro').

interpretCommand(MustBeCommand, ResultString):-
    string_lower(MustBeCommand, LowerCommand),
    re_replace("ё", "е", LowerCommand, ReplacedCommand),
    re_replace(",", "", ReplacedCommand, Command),

    format(string(ReceiveCommandMessage), "Received command for parsing: '~s'", Command),
    core_services:logDebug(ReceiveCommandMessage),

    atomic_list_concat(WordsList,' ', Command),

    parseCommand(Command, WordsList, ResultString);
    core_services:logDebug("Received invalid command"),
    ResultString = "",
    false.

parseCommand(_, WordsList, ResultString):-
    phrase(weight:weightInSpoon(X), WordsList),
    core_services:logDebug("Run weight in spoon command"),
    импадеж(X, ИмПадеж),
    родпадеж(ИмПадеж, РодПадеж),
    вСтоловойЛожкеГрамм(ИмПадеж, ВесГрамм),
    swritef(ResultString, "В столовой ложке %w грамм %w\n", [ВесГрамм, РодПадеж]);

    phrase(weight:weightInSpoonInc(X), WordsList),
    core_services:logDebug("Run increased weight in spoon command"),
    импадеж(X, ИмПадеж),
    родпадеж(ИмПадеж, РодПадеж),
    вСтоловойЛожкеГраммГорка(ИмПадеж, ВесГрамм),
    swritef(ResultString, "В столовой ложке с горкой %w грамм %w\n", [ВесГрамм, РодПадеж]);

    phrase(weight:weightInSpoonQuantity(X, КоличествоАтом), WordsList),
    core_services:logDebug("Run weight in spoon quantity command"),
    импадеж(X, ИмПадеж),
    родпадеж(ИмПадеж, РодПадеж),
    вСтоловойЛожкеГрамм(ИмПадеж, ВесГрамм),
    quantity_controller:wordToQuantity(КоличествоАтом, КоличествоЧислоАтом),
    ВесИтог is КоличествоЧислоАтом * ВесГрамм,
    swritef(ResultString, "В %w столовых ложках %w грамм %w\n", [КоличествоАтом, ВесИтог, РодПадеж]);

    phrase(me:quastionNotCorrect, AnswerList),
    atomic_list_concat(AnswerList, " ", ResultString).