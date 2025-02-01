/**
@author initkfs
*/
:- module(ingredients_case, [
    импадеж/2,
    родпадеж/2,
    имПадежРодПадежДля/3
]).

:- use_module('./../db/ingredients_all.pro').

импадеж(X, Y):- 
    ingredients_all:падеж(PIm, PList),
    memberchk(X, PList),
    Y = PIm.

падежПоИндексу(Индекс, ИмПадеж, НужныйПадеж):-
    ingredients_all:падеж(ИмПадеж, СписокПадежей),
    nth0(Индекс, СписокПадежей, НужныйПадеж).

родпадеж(ИмПадеж, РодПадеж):-
    падежПоИндексу(1, ИмПадеж, РодПадеж).

предлпадеж(ИмПадеж, ПредлПадеж):-
    падежПоИндексу(5, ИмПадеж, ПредлПадеж).

имПадежВпредлПадеж(X, ИмПадеж, ПредлПадеж):-
    импадеж(X, ИмПадеж),
    предлпадеж(ИмПадеж, ПредлПадеж).

имПадежРодПадежДля(X, ИмПадеж, РодПадеж):-
   импадеж(X, ИмПадеж),
   родпадеж(ИмПадеж, РодПадеж).