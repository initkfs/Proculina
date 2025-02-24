/**
@author initkfs
*/
:- module(info_culinary_answer, [
    
]).

:- use_module('./../../com_info_answer.pro').
    
answerAboutTheme(ОтветСтрока, ИмПадеж, ПредлПадеж, НюансыСписок):-
    com_info_answer:answerAboutTheme(ОтветСтрока, ИмПадеж, ПредлПадеж, НюансыСписок).

answerAboutThemeShort(ОтветСтрока,ИмПадеж, ПредлПадеж, НюансыСписок):-
    com_info_answer:answerAboutThemeShort(ОтветСтрока, ИмПадеж, ПредлПадеж, НюансыСписок).
