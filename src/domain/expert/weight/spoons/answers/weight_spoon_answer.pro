/**
@author initkfs
*/
:- module(weight_spoon_answer, [
    
]).
    
weightInSpoon(Ответ, ВесГрамм, РодПадеж):-
    swritef(Ответ, "В столовой ложке %w грамм %w", [ВесГрамм, РодПадеж]).

weightInTeaSpoon(Ответ, ВесГрамм, РодПадеж):-
    swritef(Ответ, "В чайной ложке %w грамм %w", [ВесГрамм, РодПадеж]).