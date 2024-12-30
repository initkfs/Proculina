:- module(app, [
    loadAppServices/3
]).

:- use_module(library(yaml)).

:- use_module('core/apps/exceptions.pro').
:- use_module('core/loggers/logger.pro').
:- use_module('core/utils/io_util.pro').
:- use_module('core/core_services.pro').

:- use_module('domain/main_command_interpreter.pro').
:- use_module('domain/main_data_processor.pro').

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
    core_services:logDebug(LoadI18nMessage).

loadConfig(Config):-
    mainConfigFile(ConfigFilePath),
    loadYamlResource(ConfigFilePath, Config).

runApp(Logger, Config, I18n):-
    loadAppServices(Logger, Config, I18n),
    loadAppData(Logger, Config, I18n).
    
loadAppServices(Logger, Config, I18n):-
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
    core_services:setI18n(I18n).

loadAppData(_, _, _):-
    main_data_processor:loadData.
