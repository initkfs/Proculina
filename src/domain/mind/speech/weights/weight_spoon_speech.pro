/** <module> Main command interpreter
@author initkfs
*/
:- module(weight_spoon_speech, [
    weightInSpoon/3,
    weightInSpoonInc/3,
    weightInSpoonQuantity/4
]).

:- use_module(library(dcg/basics)).

:- use_module('./../interact.pro').
:- use_module('./speech_weight.pro').

spoon --> ([ложка] ; [ложечка]).
inSpoon --> ([ложке] ; [ложечке]).

%масса в ложке X
weightInSpoonX(X) --> interact:request, speech_weight:weight, speech_weight:in, inSpoon, [X].

%сколько ложка содержит X
weightSpoonContains(X) --> interact:request, speech_weight:weight, spoon, speech_weight:contains, [X].
%сколько содержит ложка X
weightContainsSpoon(X) --> interact:request, speech_weight:weight, speech_weight:contains, spoon, [X].

%масса X в ложке
weightXInSpoon(X) --> interact:request, speech_weight:weight, [X], speech_weight:in, inSpoon.

weightInSpoon(X) -->  
    weightInSpoonX(X); 
    weightSpoonContains(X); 
    weightContainsSpoon(X); 
    weightXInSpoon(X).

weightInSpoonInc(X) --> weightInSpoon(X), speech_weight:weightIncreased.

weightInSpoonQuantity(X, Quantity) --> interact:request, speech_weight:weight, speech_weight:in, [Quantity], ([ложках] ; [ложечках]), [X].