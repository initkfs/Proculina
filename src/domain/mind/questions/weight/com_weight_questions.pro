/**
@author initkfs
*/
:- module(common_weight_questions, [
    
]).

:- use_module('./../../controllers/ingredients_controller.pro').

commonWeightQuestion(SpeechGoal, WordsList, WeightController, ИмПадеж, РодПадеж, WeightOut):-
    phrase(call(SpeechGoal, X), WordsList),
    ingredients_controller:имПадежРодПадежДля(X, ИмПадеж, РодПадеж),
    call(WeightController, ИмПадеж, WeightOut).