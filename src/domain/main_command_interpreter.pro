/** <module> Main command interpreter
@author initkfs
*/
:- module(main_command_interpreter, [interpretCommand/2]).

:- use_module(library(dcg/basics)).
:- use_module(library(pcre)).

:- use_module('./../core/core_services.pro').
:- use_module('./../core/utils/collection_util.pro').
:- use_module('main_data_processor.pro').

interpretCommand(Command, ResultString):-
    atomic_list_concat(WordsList,' ', Command),

    format(string(ReceiveCommandMessage), "Received command for parsing: '~s'", Command),
    core_services:logDebug(ReceiveCommandMessage),

    parseCommand(Command, WordsList, ResultString);
    core_services:getI18nValue("cliCommandInterpretError", CommandErrorText),
    ResultString = CommandErrorText,
    false.

parseCommand(_, WordsList, ResultString):-
    true.