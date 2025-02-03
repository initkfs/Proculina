/** <module> Main command interpreter
@author initkfs
*/
:- module(info_ingredients_speech, [

]).

:- use_module(library(dcg/basics)).

:- use_module('./../../com_info_speech.pro').
:- use_module('./../../../ingredients/speech/ingredients_case.pro').

ingredient(IngredientNorm, IngredientList, _):-
    is_list(IngredientList),
    length(IngredientList, IngredientListLen),
    IngredientListLen == 1,
    nth0(0, IngredientList, Ingredient),
    ingredients_case:импадеж(Ingredient, IngredientNorm).

infoAboutIngredient(IngredientNorm) --> com_info_speech:infoAboutAny, ingredient(IngredientNorm).