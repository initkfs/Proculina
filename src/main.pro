#!/usr/bin/env swipl

/** <module> Application entry point.
@author initkfs
*/

:- set_prolog_flag(verbose, silent).
:- initialization(main).

:- use_module(library(optparse)).
:- use_module(library(yaml)).

:- use_module('core/apps/exceptions.pro').
:- use_module('core/loggers/logger.pro').
:- use_module('core/utils/io_util.pro').
:- use_module('core/core_services.pro').

:- use_module('app.pro').
:- use_module('domain/main_command_interpreter.pro').

appDocBrouserPort(5050).

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
        default(''),
        shortflags([c]), 
        longflags([command]), 
        help('Natural language command for interpretation.')
    ],

    %Domain commands
    [opt(cliPermutationsFlag), 
        type(atom), 
        default(''),
        shortflags([p]), 
        longflags([perm]), 
        help('Generate permutations to simplify testing.')
    ]
]).

main(Argv) :-
    %set_prolog_flag(double_quotes, chars),
    cliOptSpec(Spec),
    optparse:opt_parse(Spec, Argv, Opts, _),

    app:loadAppServices(Logger, Config, I18n),
    !,
    
    processCli(Opts, Logger, Config, I18n);
    writeln("Nothing to do. Exit."),
    exit.

processCli(Opts, _, _, _):- 
    memberchk(cliHelpFlag(true), Opts), 
    printHelp, 
    exit;
    
    memberchk(cliVersionFlag(true), Opts), 
    printVersion, 
    exit;

    memberchk(cliRunTestsFlag(true), Opts), 
    run_tests, 
    exit;

    % FIXME flags
    % memberchk(cliPermutationsFlag(Command), Opts),
    % main_command_interpreter:writelnPermutations(Command),
    % exit;

    memberchk(cliCommandFlag(Command), Opts),
    main_command_interpreter:interpretCommand(Command, ResultString),
    writeln(ResultString),
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