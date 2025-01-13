#!/usr/bin/env swipl

/** <module> Application entry point.
@author initkfs
*/

:- set_prolog_flag(verbose, silent).

:- initialization(main).

:- use_module(library(optparse)).

:- use_module('core/utils/app_util.pro').
:- use_module('core/core_services.pro').

:- use_module('domain/main_domain.pro').

appDocBrouserPort(5050).

cliOptSpec([
    [
        opt(cliHelpFlag), 
        type(boolean),
        default(false),
        shortflags([h]), 
        longflags([help]), 
        help(['Print help.'])
    ],
    
    [
        opt(cliVersionFlag), 
        type(boolean),
        default(false),
        shortflags([v]), 
        longflags([version]), 
        help(['Print version.'])
    ],

    [
        opt(cliRunTestsFlag), 
        type(boolean),
        default(false),
        shortflags([t]), 
        longflags([test]), 
        help(['Run unit tests.'])
    ],

    [
        opt(cliRunIntegrTestsFlag), 
        type(boolean),
        default(false),
        shortflags([n]), 
        longflags([ntest]), 
        help(['Run integrations tests.'])
    ],
    
    [opt(cliDocBrowserFlag),
        type(boolean),
        default(false),
        shortflags([b]), 
        longflags([docbrowser]), 
        help(['Run documentation browser.'])
    ]
]).

main(Argv) :-
    %set_prolog_flag(double_quotes, chars),
    cliOptSpec(CoreCliSpec),
    main_domain:initCli(Argv, CoreCliSpec, AllCliSpec),
    
    optparse:opt_parse(AllCliSpec, Argv, CliOpts, _),

    init(CliOpts, Logger, Config, I18n),
    run(CliOpts, Logger, Config, I18n);

    writeln(user_error, "Nothing to do. Exit."),
    exit.

init(CliOpts, Logger, Config, I18n):-
    main_domain:initApp(CliOpts, Logger, Config, I18n), !.

run(Opts, Logger, Config, I18n):- 
    memberchk(cliHelpFlag(true), Opts), 
    printHelp, 
    exit;
    
    memberchk(cliVersionFlag(true), Opts),
    printVersion, 
    exit;

    memberchk(cliRunTestsFlag(true), Opts), 
    run_tests, 
    exit;

    main_domain:runApp(Opts, Logger, Config, I18n), 
    exit;

    memberchk(cliDocBrowserFlag(true), Opts),
    runDocServer.

printHelp:-
    cliOptSpec(CliSpec),		
    optparse:opt_help(CliSpec, HelpText),
    format('Usage:~n'),
    write(HelpText).
    
printVersion:-
    writeln(0).
    
runDocServer:-
    appDocBrouserPort(Port),
    number(Port),
    doc_server(Port),
    portray_text(true),
    writeln("Run documentation browser"),
    doc_browser.

exit:-
    app_util:exitApp.