/** <module>
@author initkfs
*/
:- module(com_long_answer, [

]).

:- use_module(library(dcg/basics)).
:- use_module('./../../../../core/core_services.pro').
:- use_module('./../speech/com_speech.pro').
:- use_module('./../speech/interact.pro').
:- use_module('./../operating/operating_db.pro').

minSentencesForLongAnwer(Value):- core_services:getConfigValue(domainConfigLongAnswerMinSentences, Value).

checkCurrentTheme(ThemeName, ThemeList, NextListItem):-
    hasTheme(ThemeName, ThemeIndex),
    format(string(FoundThemeMessage), "Found theme: ~w", ThemeName),
    core_services:logDebug(FoundThemeMessage),
    NewThemeIndex is ThemeIndex + 1,
    nextThemeItem(ThemeName, NewThemeIndex, ThemeList, NextListItem);    
    
    length(ThemeList, ThemeListLen),
    minSentencesForLongAnwer(MinSentences),
    ThemeListLen > MinSentences,
    saveNewTheme(ThemeName, 0),
    nth0(0, ThemeList, NextListItem),
    core_services:logDebug("Save new theme to file").

nextThemeItem(ThemeName, ThemeIndex, ThemeList, NextListItem):-
    length(ThemeList, ThemeLength),
    ThemeIndex < ThemeLength,
    nth0(ThemeIndex, ThemeList, NextListItem),
    saveNewTheme(ThemeName, ThemeIndex);
    abolish(operating_db_store:current_theme/2),
    operating_db:reset,
    com_speech:phraseText(interact:topicEnd, NextListItem).

hasTheme(ThemeName, ThemeIndex):-
    current_predicate(operating_db_store:current_theme/2),
    operating_db_store:current_theme(ThemeName, ThemeIndex).

saveNewTheme(ThemeName, ThemeIndex):-
    operating_db:saveWidthStream(com_long_answer:saveCurrentTheme(ThemeName, ThemeIndex)).
    
saveCurrentTheme(ThemeName, ThemeIndex, Stream):- portray_clause(Stream, current_theme(ThemeName, ThemeIndex)).