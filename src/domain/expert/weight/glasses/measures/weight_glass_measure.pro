/**
@author initkfs
*/
:- module(weight_glass_measure, [
    вСтаканеГрамм/2
]).

:- use_module('./../db/weight_glass.pro').

вСтаканеГрамм(Ингредиент, МассаГрамм):- 
    weight_glass:стаканГр(Ингредиент, МассаГрамм).
