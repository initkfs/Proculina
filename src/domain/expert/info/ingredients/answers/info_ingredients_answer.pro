/**
@author initkfs
*/
:- module(info_ingredients_answer, [
    
]).

:- use_module('./../../com_info_answer.pro').
    
answerAboutIngredient(ОтветСтрока, ПредлПадеж, НюансыСтрока):-
    com_info_answer:answerAboutTheme(ОтветСтрока, ПредлПадеж, НюансыСтрока).