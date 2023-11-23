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

:- use_module('domain/main_command_interpreter.pro').

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
        default(''),
        shortflags([c]), 
        longflags([command]), 
        help('Natural language command for interpretation.')
    ]

]).

loadYamlResource(ResourcePath, YamlContent):-
    exists_file(ResourcePath),
    open(ResourcePath, read, ResourceStream),
    yaml:yaml_read(ResourceStream, YamlContent),
    close(ResourceStream);
    throw(error(resourceLoadError(ResourcePath), _)).

loadI18nResources(Language, I18n):-
    string_concat(Language, ".yaml", ResourceFileName),
    langDir(LangDirPath),
    string_concat(LangDirPath, ResourceFileName, ResourcePath),
    loadYamlResource(ResourcePath, I18n),
    format(string(LoadI18nMessage), "Load I18n, language: ~s from ~s", [Language, ResourcePath]),
    app_services:logDebug(LoadI18nMessage).

loadConfig(Config):-
    mainConfigFile(ConfigFilePath),
    loadYamlResource(ConfigFilePath, Config).

main(Argv) :-
    %set_prolog_flag(double_quotes, chars),
    cliOptSpec(Spec),
    optparse:opt_parse(Spec, Argv, Opts, _),

    loadConfig(Config),
    core_services:setConfig(Config),

    core_services:getConfigValue(appMainLoggerLevel, LoggerLevelString),
    logger:createLogger(LoggerLevelString, Logger),
    logger:addLogHandler(logger:simpleCliLogHandler),
    core_services:setLogger(Logger),
    logger:getLoggerLevel(Logger, LoggerLevelAtom),
    format(string(LoadLoggerMessage), "Load logger, level: ~a from config level: ~s", [LoggerLevelAtom, LoggerLevelString]),
    core_services:logDebug(LoadLoggerMessage),
    
    core_services:getConfigValue(appCurrentLanguage, CurrentLanguage),
    loadI18nResources(CurrentLanguage, I18n),
    core_services:setI18n(I18n),
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