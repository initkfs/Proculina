/** <module>
@author initkfs
*/
:- module(com_info_question, [

]).

:- use_module(library(dcg/basics)).
:- use_module('./../../../core/core_services.pro').
:- use_module('./../common/speech/interact.pro').
:- use_module('./../../../core/core_services.pro').
:- use_module('./../operating/operating_db.pro').

checkCurrentTheme(ThemeName, ThemeList, NextListItem):-
    hasTheme(ThemeName, ThemeIndex),
    format(string(FoundThemeMessage), "Found theme: ~w", ThemeName),
    core_services:logDebug(FoundThemeMessage),
    NewThemeIndex is ThemeIndex + 1,
    nextThemeItem(ThemeName, NewThemeIndex, ThemeList, NextListItem);    
    
    length(ThemeList, ThemeListLen),
    ThemeListLen > 15,
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
    nth0(ThemeIndex, ThemeList, NextListItem).

hasTheme(ThemeName, ThemeIndex):-
    current_predicate(operating_db_store:current_theme/2),
    operating_db_store:current_theme(ThemeName, ThemeIndex).

saveNewTheme(ThemeName, ThemeIndex):-
    operating_db:saveWidthStream(com_info_question:saveCurrentTheme(ThemeName, ThemeIndex)).
    
saveCurrentTheme(ThemeName, ThemeIndex, Stream):- portray_clause(Stream, current_theme(ThemeName, ThemeIndex)).