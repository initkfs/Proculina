#!/usr/bin/env swipl

/** <module> Application entry point.
@author initkfs
*/

:- set_prolog_flag(verbose, silent).
:- initialization(main).

:- use_module(library(optparse)).
:- use_module(library(yaml)).
:- use_module(library(statistics)).

:- use_module('src/core/app/exceptions.pro').
:- use_module('src/core/logger/logger.pro').
:- use_module('src/core/core_services.pro').
:- use_module('src/core/util/collection_util.pro').

main(_) :-
    run_tests,
    halt.