/** <module> Main command interpreter
@author initkfs
*/
:- module(weight_spoon_speech, [
    weightInSpoon/3,
    weightInSpoonQuantity/4
]).

:- use_module(library(dcg/basics)).

:- use_module('./../interact.pro').
:- use_module('./speech_weight.pro').

%spoon --> ([ложка] ; [ложечка]).
%TODO not correct, but simplify
inSpoon --> [ложка]; [ложке] ; [ложечка]; [ложечке].
inSpoons --> [ложках] ; [ложечках].
inSpoonQuantity(Quantity) --> 
    ([Quantity], inSpoons) ; (inSpoons, [Quantity]).

weightInSpoon(X) -->  
    speech_weight:weightInContainer(X, weight_spoon_speech:inSpoon).

weightInSpoonQuantity(X, Quantity) --> speech_weight:weightInContainer(X, weight_spoon_speech:inSpoonQuantity(Quantity)).