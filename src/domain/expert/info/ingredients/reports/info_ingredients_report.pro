/**
@author initkfs
*/
:- module(info_ingredients_report, [
    
]).

:- use_module('./../db/info_ingredients.pro').

infoAboutAll(ИнгредиентАтом, ВсеНюансыСтрока):- 
    info_ingredients:всеНюансы(ИнгредиентАтом, ВсеНюансыСписок),
    atomic_list_concat(ВсеНюансыСписок,'.\n', ВсеНюансыСтрока).
