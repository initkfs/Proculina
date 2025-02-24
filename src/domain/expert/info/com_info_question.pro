/** <module>
@author initkfs
*/
:- module(com_info_question, [

]).

:- use_module('./../../../core/core_services.pro').
:- use_module('./../common/answers/com_long_answer.pro').
:- use_module('./../../../core/core_services.pro').

checkCurrentTheme(ThemeName, ThemeList, NextListItem):-
    com_long_answer:checkCurrentTheme(ThemeName, ThemeList, NextListItem).