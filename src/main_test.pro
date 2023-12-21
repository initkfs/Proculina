#!/usr/bin/env swipl

/** <module> Application entry point.
@author initkfs
*/

:- set_prolog_flag(verbose, silent).
:- initialization(main).

:- use_module('core/core_services.pro').
:- use_module('app.pro').

:- use_module('domain/main_command_interpreter.pro').

testPhrase(Phrase, ExpectedResult):-
    main_command_interpreter:interpretCommand(Phrase, CmdResult),
    format("send '~s', received: '~s'\n", [Phrase, CmdResult]),
    CmdResult = ExpectedResult;
    format("FAIL '~s'\n", [Phrase]), !.

tests:-
    InSpoonSugar20 = "В столовой ложке 20 грамм сахара",
    testPhrase("Прокулина, масса в ложке сахара", InSpoonSugar20), 
    testPhrase("Прокулина, вес в ложке сахара", InSpoonSugar20),

    testPhrase("Прокулина, сколько ложка содержит сахара", InSpoonSugar20),
    testPhrase("Прокулина, сколько сахара содержит ложка", InSpoonSugar20),

    testPhrase("Прокулина, сколько сахара в ложке", InSpoonSugar20),
    testPhrase("Прокулина, сколько сахара в ложечке", InSpoonSugar20).

main(_) :-
    app:loadAppServices(_, _, _), !,
    (tests -> 
        writeln("All test success"); 
        writeln("Fail tests")),
    exit.

exit:-
    halt.