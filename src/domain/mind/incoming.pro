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

:- use_module('controllers/ingredients_controller.pro').
:- use_module('controllers/quantity_controller.pro').
:- use_module('controllers/weight_spoons_controller.pro').
:- use_module('controllers/weight_glass_controller.pro').

:- use_module('speech/interact.pro').
:- use_module('speech/weights/weight_spoon_speech.pro').
:- use_module('speech/weights/weight_glass_speech.pro').

parseCommand(_, WordsList, ResultString):-
    phrase(weight_spoon_speech:weightInSpoon(X), WordsList),
    core_services:logDebug("Run weight in spoon command"),
    ingredients_controller:имПадежРодПадежДля(X, ИмПадеж, РодПадеж),
    weight_spoons_controller:вСтоловойЛожкеГрамм(ИмПадеж, ВесГрамм),
    swritef(ResultString, "В столовой ложке %w грамм %w", [ВесГрамм, РодПадеж]);

    phrase(weight_spoon_speech:weightInSpoonInc(X), WordsList),
    core_services:logDebug("Run increased weight in spoon command"),
    ingredients_controller:имПадежРодПадежДля(X, ИмПадеж, РодПадеж),
    weight_spoons_controller:вСтоловойЛожкеГраммГорка(ИмПадеж, ВесГрамм),
    swritef(ResultString, "В столовой ложке с горкой %w грамм %w", [ВесГрамм, РодПадеж]);

    phrase(weight_spoon_speech:weightInSpoonQuantity(X, КоличествоАтом), WordsList),
    core_services:logDebug("Run weight in spoon quantity command"),
    ingredients_controller:имПадежРодПадежДля(X, ИмПадеж, РодПадеж),
    weight_spoons_controller:вСтоловойЛожкеГрамм(ИмПадеж, ВесГрамм),
    quantity_controller:weightFromWordQuantity(КоличествоАтом, ВесГрамм, ВесИтог),
    swritef(ResultString, "В %w столовых ложках %w грамм %w", [КоличествоАтом, ВесИтог, РодПадеж]);

    phrase(weight_glass_speech:weightInGlass(X), WordsList),
    core_services:logDebug("Run weight in glass command"),
    ingredients_controller:имПадежРодПадежДля(X, ИмПадеж, РодПадеж),
    weight_glass_controller:вСтаканеГрамм(ИмПадеж, ВесГрамм),
    swritef(ResultString, "В стакане %w грамм %w", [ВесГрамм, РодПадеж]);

    phrase(weight_glass_speech:weightInGlassQuantity(X, КоличествоАтом), WordsList),
    core_services:logDebug("Run weight in glass quantity command"),
    ingredients_controller:имПадежРодПадежДля(X, ИмПадеж, РодПадеж),
    weight_glass_controller:вСтаканеГрамм(ИмПадеж, ВесГрамм),
    quantity_controller:weightFromWordQuantity(КоличествоАтом, ВесГрамм, ВесИтог),
    swritef(ResultString, "В %w стаканах %w грамм %w", [КоличествоАтом, ВесИтог, РодПадеж]);

    phrase(interact:questionNotCorrect, AnswerList),
    atomic_list_concat(AnswerList, " ", ResultString).
