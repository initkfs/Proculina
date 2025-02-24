/** <module> Main command interpreter
@author initkfs
*/
:- module(com_speech, [
   
]).

:- use_module(library(dcg/basics)).

phraseText(Phrase, PhraseText):-
    phrase(Phrase, PhraseWordsList),
    atomic_list_concat(PhraseWordsList, " ", PhraseText).
