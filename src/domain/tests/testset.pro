#!/usr/bin/env swipl

/** <module> Application entry point.
@author initkfs
*/

:- set_prolog_flag(verbose, silent).
:- initialization(main).

:- use_module('./../../core/core_services.pro').
:- use_module('./../../core/loggers/logger.pro').
:- use_module('./../../app.pro').

:- use_module('./../main_command_interpreter.pro').

testPhrase(Phrase, ExpectedResult):-
    main_command_interpreter:interpretCommand(Phrase, CmdResult),
    CmdResult = ExpectedResult;
    format("FAIL '~s'\n", [Phrase]), !.

tests:-
    InSpoonSugar20 = "В столовой ложке 20 грамм сахара",
    testPhrase("вес в ложке сахара", InSpoonSugar20), 
    testPhrase("масса сахара в ложке", InSpoonSugar20), 
    testPhrase("сахара вес в ложке", InSpoonSugar20),
    testPhrase("сахара в ложке масса", InSpoonSugar20),
    testPhrase("в ложке сахара масса", InSpoonSugar20), 
    testPhrase("в ложке масса сахара", InSpoonSugar20),

    testPhrase("сколько ложка содержит сахара", InSpoonSugar20),
    testPhrase("сколько содержит ложка сахара", InSpoonSugar20),
    testPhrase("сколько сахара содержит ложка", InSpoonSugar20).

main(_) :-
    app:loadAppServices(_, _, _), !,
    (tests -> 
        writeln("All test success"); 
        writeln("Fail tests")),
    exit.

exit:-
    halt.