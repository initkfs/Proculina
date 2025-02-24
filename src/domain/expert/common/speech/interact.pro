/** <module> Main command interpreter
@author initkfs
*/
:- module(interact, [
    questionNotCorrect/2
]).

:- use_module(library(dcg/basics)).

%{ re_match("[прокулина | proculina ][,]?"/i,Name)})
%request --> ([proculina] ; [прокулина]), (string(_) ; []).

iam --> [я].
not --> [не].
understand --> {random_member(X, [понимаю, 'могу разобрать', 'могу понять', знаю])}, [X].
thisquestion --> [этот], [вопрос].
questionNotCorrect --> iam, not, understand, thisquestion.

aboutSimple --> [о].


what --> [что].
you --> [ты].
know --> [знаешь]; [слышала] ; [помнишь]; [думаешь].
whatYouKnowAbout --> what, you, know, aboutSimple.
continueTheme --> [далее]; [дальше]; [продолжи].
thatsNotAll --> [это], [не], [все].
topicNoToContinue --> [нет], [темы], [для], [продолжения].
continueTopic --> [отрывок].
topicEnd --> [всё].

approvalUnderstand --> {random_member(X, [окей, конечно, ага, да, естественно, разумеется, 'так точно', угу])}, [X].
approvalTalk --> {random_member(X, [поговорим, расскажу, доложу, поведаю, выскажусь, вспомню, вспомним, 'поделюсь знаниями'])}, [X].