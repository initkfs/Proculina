/** <module> Core app services
@author initkfs
*/
:- module(core_services, [
    setConfig/1, 
    getConfigValue/2, 
    setI18n/1, 
    getI18nValue/2
]).

:- use_module(library(error)).
:- use_module(library(prolog_stack)).

:- use_module('src/core/logger/logger.pro').

getServiceDictValue(ServiceDict, KeyString, Value):-
    atom_string(KeyString, KeyAtom),
    Value = ServiceDict.get(KeyAtom).

isConfig:-
    current_predicate(mainConfig/1).

setConfig(Config):-
    isConfig,
    throw(error(instantiation_error("The config is already installed"), context(_, _)));
    assertz(mainConfig(Config)).

getConfigValue(KeyString, ConfigValue):-
    mainConfig(Config),
    getServiceDictValue(Config, KeyString, ConfigValue).

isI18n:-
    current_predicate(i18n/1).

setI18n(I18n):-
    isI18n,
    throw(error(instantiation_error("The I18N is already installed"), context(_, _)));
    assertz(i18n(I18n)).

getI18nValue(KeyString, Value):-
    i18n(I18n),
    getServiceDictValue(I18n, KeyString, Value).

isLogger:-
    current_predicate(mainLogger/1).

setLogger(Logger):-
    isI18n,
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