/**
@author initkfs
*/
:- module(info_ingredients_report, [
    
]).

:- use_module('./../db/info_ingredients.pro').

infoAboutAll(ИнгредиентАтом, ВсеНюансыСписок):- 
    info_ingredients:всеНюансы(ИнгредиентАтом, ВсеНюансыСписок).
