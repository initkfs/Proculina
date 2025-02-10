/**
@author initkfs
*/
:- module(info_culinary_report, [
    
]).

:- use_module('./../db/info_culinary.pro').

infoAboutAll(Тема, ВсеНюансыСписок):- 
    info_culinary:всеПравила(Тема, ВсеНюансыСписок).
    
