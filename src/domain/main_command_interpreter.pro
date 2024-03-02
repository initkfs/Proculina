/** <module> Main command interpreter
@author initkfs
*/
:- module(main_command_interpreter, [
    interpretCommand/2,
    writelnPermutations/1
    ]).

:- use_module(library(dcg/basics)).
:- use_module(library(pcre)).

:- use_module('./../core/core_services.pro').
:- use_module('./../core/utils/collection_util.pro').
:- use_module('main_data_processor.pro').
:- use_module('mind/incoming.pro').
:- use_module('mind/controllers/permutation_controller.pro').

interpretCommand(MustBeCommand, ResultString):-
    string_lower(MustBeCommand, LowerCommand),
    re_replace("ё", "е", LowerCommand, ReplacedCommand),
    re_replace(",", "", ReplacedCommand, Command),

    format(string(ReceiveCommandMessage), "Received command for parsing: '~s'", Command),
    core_services:logDebug(ReceiveCommandMessage),

    atomic_list_concat(WordsList,' ', Command),

    incoming:parseCommand(Command, WordsList, ResultString);
    core_services:logDebug("Received invalid command"),
    ResultString = "".

writelnPermutations(InputString):- 
    permutation_controller:writelnPerms(InputString).
