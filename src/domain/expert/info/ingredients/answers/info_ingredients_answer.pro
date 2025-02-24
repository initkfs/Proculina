/**
@author initkfs
*/
:- module(info_ingredients_answer, [
    
]).

:- use_module('./../../com_info_answer.pro').
    
answerAboutIngredient(ОтветСтрока, ИмПадеж, ПредлПадеж, НюансыСписок):-
    com_info_answer:answerAboutTheme(ОтветСтрока, ИмПадеж, ПредлПадеж, НюансыСписок).

answerAboutIngredientShort(ОтветСтрока, ИмПадеж, ПредлПадеж, НюансыСписок):-
    com_info_answer:answerAboutThemeShort(ОтветСтрока, ИмПадеж, ПредлПадеж, НюансыСписок).