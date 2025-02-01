/** <module> Main command interpreter
@author initkfs
*/
:- module(info_culinary_speech, [

]).

:- use_module(library(dcg/basics)).

info_any --> [расскажи]; [перечисли]; [доложи].
info --> [о] ; [об].
info --> [нюанс] ; [нюансы] ; [нюансе] ; [нюансах].

infoAboutTheme(Theme) --> info_any, info, [Theme].