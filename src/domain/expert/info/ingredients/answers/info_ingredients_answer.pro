/**
@author initkfs
*/
:- module(info_ingredients_answer, [
    
]).
    
infoAboutIngredient(ОтветСтрока, РодПадеж, НюансыСтрока):-
    swritef(ОтветСтрока, "Я знаю о %w следующее. %w", [РодПадеж, НюансыСтрока]).
