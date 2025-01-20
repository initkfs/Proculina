/**
@author initkfs
*/
:- module(weight_glass_answer, [
    
]).

weightInGlass(Ответ, ВесГрамм, РодПадеж):-
    swritef(Ответ, "В стакане %w грамм %w", [ВесГрамм, РодПадеж]).