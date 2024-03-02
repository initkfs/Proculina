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
inSpoons --> ([ложках] ; [ложечках]).

weightInSpoon(X) -->  
    speech_weight:weightInContainer(X, weight_spoon_speech:inSpoon).

weightInSpoonInc(X) --> weightInSpoon(X), speech_weight:weightIncreased.

%масса в [Quantity] ложках X
weightInSpoonQuantity(X, Quantity) --> interact:request, speech_weight:weight, speech_weight:in, [Quantity], inSpoons, [X].
%масса X в [Quantity] ложках
weightInSpoonQuantity(X, Quantity) --> interact:request, speech_weight:weight, [X],speech_weight:in, [Quantity], inSpoons.