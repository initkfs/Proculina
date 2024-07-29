/** <module> Main data service
@author initkfs
*/
:- module(main_data_processor, [
    loadData/0
]).

:- use_module('./config_keys_domain.pro').
:- use_module('./../core/loggers/logger.pro').
:- use_module('./../core/core_services.pro').
:- use_module('./../core/utils/io_util.pro').

:- use_module('./../domain/mind/db/ingredients.pro').

:- use_module(library(csv)).

loadData:-
    config_keys_domain:ingredientsDir(ConfigIngredDirAtom),
    core_services:getConfigValue(ConfigIngredDirAtom, IngredDirString),
    loadIngredientsDir(IngredDirString).
   
loadIngredientsDir(IngredDirString):-
    exists_directory(IngredDirString),
    format(string(FoundIngredDirMessage), "Found ingredient directory ~w", IngredDirString),
    logTrace(FoundIngredDirMessage),
    loadIngredients(IngredDirString);

    format(string(NoFoundIngredDirMessage), "Not found ingredient directory ~w", IngredDirString),
    logError(NoFoundIngredDirMessage),
    fail.

loadIngredients(IngredDirString):-
    %TODO extract path config
    dirRegularFiles(IngredDirString, IngredDirFiles),
    length(IngredDirFiles, IngredDirLength),
    format(string(FoundIngredFilesMessage), "Found ~d files from directory ~w: ~w", [IngredDirLength, IngredDirString, IngredDirFiles]),
    logTrace(FoundIngredFilesMessage),
    loadIngredFile(IngredDirFiles).

loadIngredFile([]).
loadIngredFile([File|Rest]):-
    csv_read_file(File, ContentCSV, []),
    ContentCSV = [_|Rows],
    % ContentCSV = [Colnames|Rows],
    % Colnames =.. [row|Names],
    addIngredient(Rows),
    loadIngredFile(Rest).

addIngredient([]).
addIngredient([IngredRow | Rest]):-
    IngredRow =.. [row | IngredData],
    nth0(0, IngredData, IngredientName),
    atom(IngredientName),
    ingredients:ингредиентДобавить(IngredientName),
    sliceList(IngredData, 0, 2, IngredCasesList),
    ingredients:падежДобавить(IngredientName, IngredCasesList),
    addIngredient(Rest).

sliceList(List, FromIndexIncl, ToIndexExcl, Rest):-
    is_list(List),
    length(FromList, FromIndexIncl),
    length(ToList, ToIndexExcl),
    append(ToList, _, List),
    append(FromList, Rest, ToList).