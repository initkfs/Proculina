/** <module> Main command interpreter
@author initkfs
*/
:- module(info_culinary_speech, [

]).

:- use_module(library(dcg/basics)).
:- use_module('./../../com_info_speech.pro').

infoAboutTheme(Theme) --> com_info_speech:infoAboutAny, [Theme].