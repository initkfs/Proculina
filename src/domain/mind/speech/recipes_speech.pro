/**
@author initkfs
*/
:- module(recipes_speech, [
    recipes_all/3
]).

:- use_module(library(dcg/basics)).

recipe --> [рецепт] ; [рецептик].

recipes_all(RecipeName) --> recipe, dcg:basics:dcg_basics:string(RecipeName).
