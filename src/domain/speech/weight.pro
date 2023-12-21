/** <module> Main command interpreter
@author initkfs
*/
:- module(weight, [
    weightInSpoon/3,
    weightSpoonIncreased/2,
    weightInSpoonQuantity/4
]).

:- use_module(library(dcg/basics)).

:- use_module('./me.pro').

weight --> [сколько] ; [количество] ; [вес] ; [масса] ; [объем].
in --> [в].
spoon --> ([ложка] ; [ложечка]).
inSpoon --> ([ложке] ; [ложечке]).
contains -->  ([содержит] ; [вмещает] ; [несет]).

weightSpoonIncreased --> [с], ([горкой] ; [горочкой]; [верхом]).

%масса в ложке X
weightInSpoonX(X) --> me:request, weight, in, inSpoon, [X].

%сколько ложка содержит X
weightSpoonContains(X) --> me:request, weight, spoon, contains, [X].
%сколько содержит ложка X
weightContainsSpoon(X) --> me:request, weight, contains, spoon, [X].

%масса X в ложке
weightXInSpoon(X) --> me:request, weight, [X], in, inSpoon.

weightInSpoon(X) -->  
    weightInSpoonX(X); 
    weightSpoonContains(X); 
    weightContainsSpoon(X); 
    weightXInSpoon(X).

weightInSpoonInc(X) --> weightInSpoon(X), weightSpoonIncreased.

weightInSpoonQuantity(X, Quantity) --> me:request, weight, in, [Quantity], ([ложках] ; [ложечках]), [X].