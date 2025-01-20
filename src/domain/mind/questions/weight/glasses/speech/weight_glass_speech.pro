/** <module> Main command interpreter
@author initkfs
*/
:- module(weight_glass_speech, [
    weightInGlass/3,
    weightInGlassQuantity/4
]).

:- use_module(library(dcg/basics)).

:- use_module('./../../../../speech/interact.pro').
:- use_module('./../../com_weight_speech.pro').

inGlass --> [стакан]; [стакане] ; [стаканчик]; [стаканчике].
inGlasses --> ([стаканы]; [стаканах]).
inGlassesQuantity(Quantity) --> 
    ([Quantity], inGlasses) ; (inGlasses, [Quantity]).

weightInGlass(X) -->  
    com_weight_speech:weightInContainer(X, weight_glass_speech:inGlass).

weightInGlassQuantity(X, Quantity) -->  com_weight_speech:weightInContainer(X, weight_glass_speech:inGlassesQuantity(Quantity)).