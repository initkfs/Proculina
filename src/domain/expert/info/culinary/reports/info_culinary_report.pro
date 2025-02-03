/**
@author initkfs
*/
:- module(info_culinary_report, [
    
]).

:- use_module('./../db/info_culinary.pro').

infoAboutAll(Тема, ВсеНюансыСтрока):- 
    info_culinary:всеПравила(Тема, ВсеНюансыСписок),
    atomic_list_concat(ВсеНюансыСписок,'.', ВсеНюансыСтрока).
    
