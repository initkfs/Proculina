/** <module> Main command interpreter
@author initkfs
*/
:- module(weight, [
    weightInSpoon/3,
    weightInSpoon1/3,
    weightInSpoon2/3,
    weightSpoonIncreased/2,
    weightInSpoonQuantity/4
]).

:- use_module(library(dcg/basics)).

:- use_module('./me.pro').

weight --> [сколько] ; [количество] ; [вес] ; [масса] ; [объем].
in --> [в].
spoon --> ([ложка] ; [ложечка]).
inSpoon --> ([ложке] ; [ложечке]).

weightSpoonIncreased --> [с], ([горкой] ; [горочкой]; [верхом]).

weightInSpoon1(X) --> me:request, weight, in, inSpoon, [X].
weightInSpoon2(X) --> me:request, weight, spoon, ([содержит] ; [вмещает] ; [несет]), [X].
weightInSpoon3(X) --> me:request, weight, [X], in, inSpoon.
weightInSpoon(X) -->  weightInSpoon1(X) ; weightInSpoon2(X) ; weightInSpoon3(X).
weightInSpoonInc(X) --> weightInSpoon(X), weightSpoonIncreased.

weightInSpoonQuantity(X, Quantity) --> me:request, weight, in, [Quantity], ([ложках] ; [ложечках]), [X].