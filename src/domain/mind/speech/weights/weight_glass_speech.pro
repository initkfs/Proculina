/** <module> Main command interpreter
@author initkfs
*/
:- module(weight_glass_speech, [
    weightInGlass/3,
    weightInGlassQuantity/4
]).

:- use_module(library(dcg/basics)).

:- use_module('./../interact.pro').
:- use_module('./speech_weight.pro').

inGlass --> [стакан]; [стакане] ; [стаканчик]; [стаканчике].
inGlasses --> ([стаканы]; [стаканах]).
inGlassesQuantity(Quantity) --> 
    ([Quantity], inGlasses) ; (inGlasses, [Quantity]).

weightInGlass(X) -->  
    speech_weight:weightInContainer(X, weight_glass_speech:inGlass).

weightInGlassQuantity(X, Quantity) -->  speech_weight:weightInContainer(X, weight_glass_speech:inGlassesQuantity(Quantity)).