/** <module> Main command interpreter
@author initkfs
*/
:- module(com_info_speech, [

]).

:- use_module(library(dcg/basics)).
:- use_module('./../common/speech/interact.pro').

infoAny --> [расскажи]; [перечисли]; [доложи]; [давай]; [опиши].
info --> [о] ; [об].
nuance --> [нюанс] ; [нюансы] ; [нюансе] ; [нюансах].

infoAbout --> infoAny, info.
infoAboutNuance --> infoAbout, nuance.

infoAboutAny --> infoAbout.
infoAboutAny --> infoAboutNuance.
infoAboutAny --> interact:whatYouKnowAbout.