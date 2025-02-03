/**
@author initkfs
*/
:- module(info_culinary_answer, [
    
]).

:- use_module('./../../com_info_answer.pro').
    
answerAboutTheme(ОтветСтрока, ПредлПадеж, НюансыСтрока):-
    com_info_answer:answerAboutTheme(ОтветСтрока, ПредлПадеж, НюансыСтрока).
