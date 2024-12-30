/**
@author initkfs
*/
:- module(logger, [
    createLogger/2, 
    getLoggerLevel/2,
    addLogHandler/1,
    simpleCliLogHandler/2,
    logError/2,
    logWarn/2,
    logInfo/2,
    logDebug/2,
    logTrace/2
]).

:- use_module(library(error)).
:- use_module(library(prolog_stack)).

logLevels([error, warn, info, debug, trace, all]).

isValidLevel(LogLevelAtom, LogLevelRankIndex):-
    logLevels(LogLevelsArray),
    nth0(LogLevelRankIndex, LogLevelsArray, LogLevelAtom).

createLogger(LogLevelString, LoggerDict):-
    atom_string(LogLevelAtom, LogLevelString),
    createLoggerDict(LogLevelAtom, LoggerDict).

createLoggerDict(LogLevelAtom, LoggerDict):-
    not(isValidLevel(LogLevelAtom, _)),
    logLevels(LogLevelsArray),
    throw(error(domain_error(LogLevelsArray, LogLevelAtom), context(_, "")));
    LoggerDict = logger{level:LogLevelAtom}.

getLoggerLevel(LoggerDict, LevelAtom):-
    not(is_dict(LoggerDict)),
    throw(error(type_error("Dict", LoggerDict), context(_, "")));
    get_dict(level, LoggerDict, LevelAtom).

isForLevel(LevelValueAtom, LoggerDict):-
    isValidLevel(LevelValueAtom, LevelRankIndex),
    getLoggerLevel(LoggerDict, LoggerLevel),
    isValidLevel(LoggerLevel, LoggerLevelRankIndex),
    !,
    LoggerLevelRankIndex >= LevelRankIndex.

logError(LoggerDict, Message):-
    logForLevel(error, LoggerDict, Message).

logWarn(LoggerDict, Message):-
    logForLevel(warn, LoggerDict, Message).

logInfo(LoggerDict, Message):-
    logForLevel(info, LoggerDict, Message).

logDebug(LoggerDict, Message):-
    logForLevel(debug, LoggerDict, Message).

logTrace(LoggerDict, Message):-
    logForLevel(trace, LoggerDict, Message).

logForLevel(LogLevelAtom, LoggerDict, Message):-
    isForLevel(LogLevelAtom, LoggerDict),
    log(LogLevelAtom, Message);
    true.

log(LevelAtom, Message):-
    not(isLogHandlerDefined);
    forall(logHandler(Handler), call(Handler, LevelAtom, Message)).

isLogHandlerDefined:-
    current_predicate(logHandler/1).

addLogHandler(Handler):-
    isLogHandlerDefined,
    logHandler(Handler), 
    throw(error(instantiation_error("The logger handler is already installed"), context(_, Handler)));
    assertz(logHandler(Handler)).

simpleCliLogHandler(LogLevel, LogMessage):-
    get_time(Time),
    stamp_date_time(Time, Date, 'UTC'),
    format_time(string(DateTimeInfo),
                    '%d.%m.%Y %T UTC',
                    Date, posix),
    format(string(Message), "~s ~a: ~w", [DateTimeInfo, LogLevel, LogMessage]),
    writeln(Message),
    flush_output.