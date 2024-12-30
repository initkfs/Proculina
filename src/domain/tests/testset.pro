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
    checkTestPhrase(Phrase, CmdResult, ExpectedResult).

checkTestPhrase(Phrase, ActualResult, ExpectedResult):-
    not(ActualResult == ExpectedResult),
    format("FAIL. Received '~s' for phrase '~s', but expected '~s'\n", [ActualResult, Phrase, ExpectedResult]), 
    false;
    true.

tests:-
    InSpoonSugar20 = "В столовой ложке 20 грамм сахара",
    testPhrase("масса в ложке сахара", InSpoonSugar20),
    testPhrase("масса сахара в ложке", InSpoonSugar20),
    testPhrase("сахара масса в ложке", InSpoonSugar20), 
    testPhrase("в ложке сахара масса", InSpoonSugar20),
    testPhrase("в ложке масса сахара", InSpoonSugar20),

    testPhrase("сколько ложка содержит сахара", InSpoonSugar20),
    testPhrase("сколько содержит ложка сахара", InSpoonSugar20),
    testPhrase("сколько сахара содержит ложка", InSpoonSugar20).

main(_) :-
    app:runApp(_, _, _), !,
    (tests -> 
        writeln("All test running"); 
        writeln("Fail test running")),
    exit.

exit:-
    halt.