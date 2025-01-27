/**
@author initkfs
*/
:- module(recipes_controller, [
    рецептВесь/2
]).

:- use_module('./db/recipes_all.pro').

рецептВесь(Имя, Рецепт):- 
    recipes_all:рецепт(Имя, Рецепт).