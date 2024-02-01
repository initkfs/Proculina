/** <module> Main command interpreter
@author initkfs
*/
:- module(weight, [
    weightInSpoon/3,
    weightSpoonIncreased/2,
    weightInSpoonQuantity/4,
    weightInGlass/3,
    weightInGlassQuantity/4
]).

:- use_module(library(dcg/basics)).

:- use_module('./interact.pro').

weight --> [сколько] ; [количество] ; [вес] ; [масса] ; [объем].
in --> [в].
spoon --> ([ложка] ; [ложечка]).
inSpoon --> ([ложке] ; [ложечке]).
contains -->  ([содержит] ; [вмещает] ; [несет]).

weightSpoonIncreased --> [с], ([горкой] ; [горочкой]; [верхом]).

%масса в ложке X
weightInSpoonX(X) --> interact:request, weight, in, inSpoon, [X].

%сколько ложка содержит X
weightSpoonContains(X) --> interact:request, weight, spoon, contains, [X].
%сколько содержит ложка X
weightContainsSpoon(X) --> interact:request, weight, contains, spoon, [X].

%масса X в ложке
weightXInSpoon(X) --> interact:request, weight, [X], in, inSpoon.

weightInSpoon(X) -->  
    weightInSpoonX(X); 
    weightSpoonContains(X); 
    weightContainsSpoon(X); 
    weightXInSpoon(X).

weightInSpoonInc(X) --> weightInSpoon(X), weightSpoonIncreased.

weightInSpoonQuantity(X, Quantity) --> interact:request, weight, in, [Quantity], ([ложках] ; [ложечках]), [X].

glass --> ([стакан] ; [стаканчик]).
inGlass --> ([стакане] ; [стаканчике]).

%масса в стакане X
weightInGlassX(X) --> interact:request, weight, in, inGlass, [X].

%сколько стакан содержит X
weightGlassContains(X) --> interact:request, weight, glass, contains, [X].
%сколько содержит стакан X
weightContainsGlass(X) --> interact:request, weight, contains, glass, [X].

%масса X в стакане
weightXInGlass(X) --> interact:request, weight, [X], in, inGlass.

weightInGlass(X) -->  
    weightInGlassX(X); 
    weightGlassContains(X); 
    weightContainsGlass(X); 
    weightXInGlass(X).

weightInGlassQuantity(X, Quantity) --> interact:request, weight, in, [Quantity], ([стаканах] ; [стаканчиках]), [X].