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

glass --> ([стакан] ; [стаканчик]).
inGlass --> ([стакане] ; [стаканчике]).

%масса в стакане X
weightInGlassX(X) --> interact:request, speech_weight:weight, speech_weight:in, inGlass, [X].

%сколько стакан содержит X
weightGlassContains(X) --> interact:request, speech_weight:weight, glass, speech_weight:contains, [X].
%сколько содержит стакан X
weightContainsGlass(X) --> interact:request, speech_weight:weight, speech_weight:contains, glass, [X].

%масса X в стакане
weightXInGlass(X) --> interact:request, speech_weight:weight, [X], speech_weight:in, inGlass.

weightInGlass(X) -->  
    weightInGlassX(X); 
    weightGlassContains(X); 
    weightContainsGlass(X); 
    weightXInGlass(X).

weightInGlassQuantity(X, Quantity) --> interact:request, speech_weight:weight, speech_weight:in, [Quantity], ([стаканах] ; [стаканчиках]), [X].