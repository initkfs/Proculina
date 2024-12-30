/** <module> Core app services
@author initkfs
*/
:- module(core_services, [
    setConfig/1, 
    getConfigValue/2, 
    setI18n/1, 
    getI18nValue/2,
    logDebug/1,
    logWarn/1,
    logError/1,
    logInfo/1,
    logTrace/1
]).

:- use_module(library(error)).
:- use_module(library(prolog_stack)).

:- use_module('src/core/loggers/logger.pro').

getServiceDictValue(ServiceDict, KeyAtom, Value):-
    Value = ServiceDict.get(KeyAtom).

hasConfig:-
    current_predicate(mainConfig/1).

setConfig(Config):-
    hasConfig,
    throw(error(instantiation_error("The config is already installed"), context(_, _)));
    assertz(mainConfig(Config)).

getConfigValue(KeyString, ValueAtom):-
    mainConfig(Config),
    getServiceDictValue(Config, KeyString, ValueAtom).

hasI18n:-
    current_predicate(i18n/1).

setI18n(I18n):-
    hasI18n,
    throw(error(instantiation_error("The I18N is already installed"), context(_, _)));
    assertz(i18n(I18n)).

getI18nValue(KeyString, Value):-
    i18n(I18n),
    getServiceDictValue(I18n, KeyString, Value).

hasLogger:-
    current_predicate(mainLogger/1).

setLogger(Logger):-
    hasLogger,
    throw(error(instantiation_error("The logger is already installed"), context(_, _)));
    assertz(mainLogger(Logger)).

getLogger(Logger):-
    mainLogger(Logger).

logError(Message):-
    getLogger(Logger),
    logger:logError(Logger, Message).

logWarn(Message):-
    getLogger(Logger),
    logger:logWarn(Logger, Message).

logInfo(Message):-
    getLogger(Logger),
    logger:logInfo(Logger, Message).

logDebug(Message):-
    getLogger(Logger),
    logger:logDebug(Logger, Message).

logTrace(Message):-
    getLogger(Logger),
    logger:logTrace(Logger, Message).