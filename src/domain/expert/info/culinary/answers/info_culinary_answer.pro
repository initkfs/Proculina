/**
@author initkfs
*/
:- module(info_culinary_answer, [
    
]).
    
answerAboutTheme(ОтветСтрока, ПредлПадеж, НюансыСтрока):-
    swritef(ОтветСтрока, "Конечно, итак о %w. %w", [ПредлПадеж, НюансыСтрока]).
