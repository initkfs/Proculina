/** <module> Main command interpreter
@author initkfs
*/
:- module(me, [
    request/2,
    quastionNotCorrect/2
]).

:- use_module(library(dcg/basics)).

%{ re_match("[прокулина | proculina ][,]?"/i,Name)})
request --> ([proculina] ; [прокулина]), (string(_) ; []).

iam --> [я].
not --> [не].
understand --> {random_member(X, [понимаю, 'могу разобрать', 'могу понять', знаю])}, [X].
thisquestion --> [этот], [вопрос].
quastionNotCorrect --> iam, not, understand, thisquestion.