/** <module> Main command interpreter
@author initkfs
*/
:- module(weight_spoon_speech, [
    weightInSpoon/3,
    weightInSpoonQuantity/4
]).

:- use_module(library(dcg/basics)).

:- use_module('./../../../../common/speech/interact.pro').
:- use_module('./../../com_weight_speech.pro').

%spoon --> ([ложка] ; [ложечка]).
%TODO not correct, but simplify
inSpoon --> [ложка]; [ложке] ; [ложечка]; [ложечке].
inSpoons --> [ложках] ; [ложечках].
inSpoonQuantity(Quantity) --> 
    ([Quantity], inSpoons) ; (inSpoons, [Quantity]).

weightInSpoon(X) -->  
    com_weight_speech:weightInContainer(X, weight_spoon_speech:inSpoon).

weightInSpoonQuantity(X, Quantity) --> com_weight_speech:weightInContainer(X, weight_spoon_speech:inSpoonQuantity(Quantity)).

inTeaSpoon --> ([чайная],[ложка]); ([чайной],[ложке]) ; ([чайная],[ложечка]); ([чайной],[ложечка]).
inTeaSpoons --> ([чайных],[ложках]) ; ([чайных],[ложечках]).
inTeaSpoonQuantity(Quantity) --> 
    ([Quantity], inTeaSpoons) ; (inTeaSpoons, [Quantity]).

weightInTeaSpoon(X) -->  
    com_weight_speech:weightInContainer(X, weight_spoon_speech:inTeaSpoon).

weightInTeaSpoonQuantity(X, Quantity) --> com_weight_speech:weightInContainer(X, weight_spoon_speech:inTeaSpoonQuantity(Quantity)).