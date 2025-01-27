/**
@author initkfs
*/
:- module(ingredients, [
   ингредиент/1,
   ингредиентДобавить/1,
   падежДобавить/2,
   падеж/2
]).

ингредиентДобавить(Имя):-
    assertz(ингредиентИмя(Имя)).

ингредиентНайти(X):-
    ингредиентИмя(X).

ингредиент(дрожжи).
ингредиент(крахмал).
ингредиент(молоко).
ингредиент(мука).
ингредиент(сахар).
ингредиент(сметана).
ингредиент(соль).
ингредиент(сода).

%И(кто? что?), Р(кого? чего?), Д(кому? чему?), В(кого? что?), Т(кем? чем?), П(о ком? о чём?) 
падеж(вода, [вода, воды]).
падеж(дрожжи, [дрожжи, дрожжей]).
падеж(крахмад, [крахмал, крахмала]).
падеж(молоко, [молоко, молока]).
падеж(мука, [мука, муки]).
падеж(сахар, [сахар, сахара]).
падеж(сметана, [сметана, сметаны]).
падеж(соль, [соль, соли]).
падеж(сода, [сода, соды]).

падежДобавить(ИмПадеж, ПадежиСписок):-
    assertz(падежПоИмени(ИмПадеж, ПадежиСписок)).

% падеж(ИмПадеж, ПадежиСписок):-
%     падежПоИмени(ИмПадеж, ПадежиСписок).
