/** <module> Main command interpreter
@author initkfs
*/
:- module(com_info_answer, [

]).

:- use_module(library(dcg/basics)).
:- use_module('./../common/speech/com_speech.pro').
:- use_module('./../common/speech/interact.pro').

answerAbout(Theme) --> interact:approvalTalk, interact:aboutSimple, [Theme].

answerAboutTheme(AnswerString, _, ThemeAbout, ContentList):-
    phrase(interact:approvalUnderstand, PhraseUndestandList),
    atomic_list_concat(PhraseUndestandList, " ", PhraseUndestandString),
    phrase(com_info_answer:answerAbout(ThemeAbout), PhraseResultList),
    atomic_list_concat(PhraseResultList, " ", PhraseResultString),
    atomic_list_concat(ContentList, ".", ContentString),
    swritef(AnswerString, "%w, %w. %w", [PhraseUndestandString, PhraseResultString, ContentString]).

answerAboutThemeShort(AnswerString, _, ThemeAbout, ContentList):-
    atomic_list_concat(ContentList, ".", ContentString),
    com_speech:phraseText(interact:aboutSimple, AboutSimple),
    com_speech:phraseText(interact:continueTopic, AboutParts),
    swritef(AnswerString, "%w %w %w. %w", [AboutParts, AboutSimple, ThemeAbout, ContentString]).