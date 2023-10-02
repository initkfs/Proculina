#!/usr/bin/env swipl

/** <module> Application entry point.
@author initkfs
*/

:- set_prolog_flag(verbose, silent).
:- initialization(main).

:- use_module(library(optparse)).
:- use_module(library(yaml)).

:- use_module('src/core/apps/exceptions.pro').
:- use_module('src/core/loggers/logger.pro').
:- use_module('src/core/utils/io_util.pro').

appVersion("0.1a").
appDocBrouserPort(5050).
appDataDir(Path):- Path = "./data/".

withDataDir(SomeDir, Path):-
    appDataDir(DataDirPath),
    string_concat(DataDirPath, SomeDir, Path).

mainConfigFile(Path):-
    withDataDir("configs/main.yaml", Path).
    
langDir(Path):-
    withDataDir("langs/", Path).

cliOptSpec([
    [
        opt(cliHelpFlag), 
        type(boolean),
        default(false),
        shortflags([h]), 
        longflags([help]), 
        help('Print help.')
    ],
    
    [
        opt(cliVersionFlag), 
        type(boolean),
        default(false),
        shortflags([v]), 
        longflags([version]), 
        help('Print version.')
    ],

    [
        opt(cliRunTestsFlag), 
        type(boolean),
        default(false),
        shortflags([t]), 
        longflags([test]), 
        help('Run unit tests.')
    ],
    
    [opt(cliDocBrowserFlag),
        type(boolean),
        default(false),
        shortflags([b]), 
        longflags([docbrowser]), 
        help('Run documentation browser.')
    ],

    [opt(cliCommandFlag), 
        type(atom), 
        default('command'),
        shortflags([c]), 
        longflags([command]), 
        help('Natural language command for interpretation.')
    ]

]).

main(Argv) :-
    cliOptSpec(Spec),
    optparse:opt_parse(Spec, Argv, Opts, _),
    
    processCli(Opts);
    writeln("Nothing to do. Exit."),
    exit.

processCli(Opts):- 
    memberchk(cliHelpFlag(true), Opts), 
    printHelp, 
    exit;
    
    memberchk(cliVersionFlag(true), Opts), 
    printVersion, 
    exit;

    memberchk(cliRunTestsFlag(true), Opts), 
    run_tests, 
    exit;
    
    memberchk(cliDocBrowserFlag(true), Opts), 
    runDocServer.

printHelp:-
    cliOptSpec(CliSpec),		
    optparse:opt_help(CliSpec, HelpText),
    format('Usage:~n'),
    write(HelpText).
    
printVersion:-
    appVersion(Version),
    writeln(Version).
    
runDocServer:-
    appDocBrouserPort(Port),
    number(Port),
    doc_server(Port),
    portray_text(true),
    writeln("Run documentation browser"),
    doc_browser.

exit:-
    halt.