/** <module> Main command interpreter
@author initkfs
*/
:- module(speech_weight, [
    weight/2,
    weightIncreased/2,
    in/2,
    contains/2,
    weightInContainer/4,
    weightInContainerX/4,
    weightXInContainer/4,
    inContainerXweight/4,
    inContainerWeightX/4,
    xWeightInContainer/4,
    xInContainerWeight/4,
    weightContainerContains/4,
    weightContainsContainer/4,
    weightContainsContainer/4
]).

:- use_module(library(dcg/basics)).

:- use_module('./../interact.pro').

weight --> [сколько] ; [количество] ; [вес] ; [масса] ; [объем].
weightIncreased --> [с], ([горкой] ; [горочкой]; [верхом]).
in --> [в].
contains -->  ([содержит] ; [вмещает] ; [несет]).

%масса в контейнере X
weightInContainerX(X, InContainerRule) --> weight, in, InContainerRule, [X].
%масса X в контейнере
weightXInContainer(X, InContainerRule) --> weight, [X], in, InContainerRule.
%X масса в контейнере
xWeightInContainer(X, InContainerRule) --> [X], weight, in, InContainerRule.
%X в контейнере масса
xInContainerWeight(X, InContainerRule) --> [X], in, InContainerRule, weight.
%в контейнере X масса
inContainerXweight(X, InContainerRule) --> in, InContainerRule, [X], weight.
%в контейнере масса X
inContainerWeightX(X, InContainerRule) --> in, InContainerRule, weight, [X].

%сколько контейнер содержит X
weightContainerContains(X, InContainerRule) --> weight, InContainerRule, contains, [X].
%сколько содержит контейнер X
weightContainsContainer(X, InContainerRule) --> weight, contains, InContainerRule, [X].
%сколько X содержит контейнер
weightContainsContainer(X, InContainerRule) --> weight, [X], contains, InContainerRule.

weightInContainer(X, InContainerRule) -->  
    weightInContainerX(X, InContainerRule); 
    weightXInContainer(X, InContainerRule); 
    inContainerXweight(X, InContainerRule); 
    inContainerWeightX(X, InContainerRule);
    xWeightInContainer(X, InContainerRule);
    xInContainerWeight(X, InContainerRule);
    weightContainerContains(X, InContainerRule);
    weightContainsContainer(X, InContainerRule);
    weightContainsContainer(X, InContainerRule).