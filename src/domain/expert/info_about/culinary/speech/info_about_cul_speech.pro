/** <module> Main command interpreter
@author initkfs
*/
:- module(info_about_cul_speech, [

]).

:- use_module(library(dcg/basics)).

:- use_module('./../../../common/speech/interact.pro').
:- use_module('./../../../ingredients/speech/ingredients_case.pro').

info_about_any --> [расскажи]; [перечисли]; [доложи].
info_about --> [о] ; [об].
info_about --> [нюанс] ; [нюансы] ; [нюансе] ; [нюансах].

ingredient(IngredientNorm, IngredientList, _):-
    is_list(IngredientList),
    length(IngredientList, IngredientListLen),
    IngredientListLen == 1,
    nth0(0, IngredientList, Ingredient),
    ingredients_case:импадеж(Ingredient, IngredientNorm).

infoAboutIngredient(IngredientNorm) --> info_about_any, info_about, ingredient(IngredientNorm).