/** <module> Main command interpreter
@author initkfs
*/
:- module(speech_weight, [
    weight/2,
    weightIncreased/2,
    in/2,
    contains/2
]).

:- use_module(library(dcg/basics)).

:- use_module('./../interact.pro').

weight --> [сколько] ; [количество] ; [вес] ; [масса] ; [объем].
weightIncreased --> [с], ([горкой] ; [горочкой]; [верхом]).
in --> [в].
contains -->  ([содержит] ; [вмещает] ; [несет]).
