/** <module> Main command interpreter
@author initkfs
*/
:- module(com_info_answer, [

]).

:- use_module(library(dcg/basics)).
:- use_module('./../common/speech/interact.pro').

answerAbout(Theme) --> interact:approvalTalk, interact:aboutSimple, [Theme].

answerAboutTheme(AnswerString, Theme, ContentList):-
    phrase(interact:approvalUnderstand, PhraseUndestandList),
    atomic_list_concat(PhraseUndestandList, " ", PhraseUndestandString),
    phrase(com_info_answer:answerAbout(Theme), PhraseResultList),
    atomic_list_concat(PhraseResultList, " ", PhraseResultString),
    atomic_list_concat(ContentList, ".", ContentString),
    swritef(AnswerString, "%w, %w. %w", [PhraseUndestandString, PhraseResultString, ContentString]).
