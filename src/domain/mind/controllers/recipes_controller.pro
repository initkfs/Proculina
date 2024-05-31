/**
@author initkfs
*/
:- module(recipes_controller, [
    рецептВесь/2
]).

:- use_module('./../db/recipes.pro').

рецептВесь(Имя, Рецепт):- 
    recipes:рецепт(Имя, Рецепт).