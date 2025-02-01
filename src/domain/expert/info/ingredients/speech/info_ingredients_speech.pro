/** <module> Main command interpreter
@author initkfs
*/
:- module(info_ingredients_speech, [

]).

:- use_module(library(dcg/basics)).

:- use_module('./../../../common/speech/interact.pro').
:- use_module('./../../../ingredients/speech/ingredients_case.pro').

info_any --> [расскажи]; [перечисли]; [доложи].
info --> [о] ; [об].
info --> [нюанс] ; [нюансы] ; [нюансе] ; [нюансах].

ingredient(IngredientNorm, IngredientList, _):-
    is_list(IngredientList),
    length(IngredientList, IngredientListLen),
    IngredientListLen == 1,
    nth0(0, IngredientList, Ingredient),
    ingredients_case:импадеж(Ingredient, IngredientNorm).

infoAboutIngredient(IngredientNorm) --> info_any, info, ingredient(IngredientNorm).