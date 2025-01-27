/**
@author initkfs
*/
:- module(common_weight_questions, [
    
]).

:- use_module('./../../ingredients/speech/ingredients_case.pro').

commonWeightQuestion(SpeechGoal, WordsList, WeightController, ИмПадеж, РодПадеж, WeightOut):-
    phrase(call(SpeechGoal, X), WordsList),
    ingredients_case:имПадежРодПадежДля(X, ИмПадеж, РодПадеж),
    call(WeightController, ИмПадеж, WeightOut).