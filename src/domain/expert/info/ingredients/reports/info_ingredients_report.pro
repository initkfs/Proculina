/**
@author initkfs
*/
:- module(info_ingredients_report, [
    
]).

:- use_module('./../db/info_ingredients.pro').

infoAboutAll(ИнгредиентАтом, ВсеНюансыТекст):- 
    ВсеНюансыТекст = "Все нюансы".
