/** <module> Main command interpreter
@author initkfs
*/
:- module(main_command_interpreter, [interpretCommand/2]).

:- use_module(library(dcg/basics)).
:- use_module(library(pcre)).

:- use_module('./../core/core_services.pro').
:- use_module('./../core/utils/collection_util.pro').
:- use_module('main_data_processor.pro').

:- use_module('databases/ru/ingredients.pro').

sys --> [proculina] ; [прокулина].
weightInSpoon(X) --> sys, [сколько], [в], [ложке], [X].

interpretCommand(Command, ResultString):-
    atomic_list_concat(WordsList,' ', Command),

    format(string(ReceiveCommandMessage), "Received command for parsing: '~s'", Command),
    core_services:logDebug(ReceiveCommandMessage),

    parseCommand(Command, WordsList, ResultString);
    core_services:logDebug("Received invalid command"),
    ResultString = CommandErrorText,
    false.

parseCommand(_, WordsList, ResultString):-
    phrase(weightInSpoon(X), WordsList),
    core_services:logDebug("Run weight in spoon command"),
    импадеж(X, ИмПадеж),
    вСтоловойЛожкеГрамм(ИмПадеж, Y),
    writeln(Y);
    writeln("Invalid command for parsing"),
    true.