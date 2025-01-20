/** <module> Main command interpreter
@author initkfs
*/
:- module(main_command_interpreter, [
    interpretCommand/2,
    writelnPermutations/1
    ]).

:- use_module(library(dcg/basics)).
:- use_module(library(pcre)).

:- use_module('./../core/core_services.pro').
:- use_module('./../core/utils/collection_util.pro').
:- use_module('main_data_processor.pro').
:- use_module('mind/controllers/permutation_controller.pro').

:- use_module('mind/controllers/ingredients_controller.pro').
:- use_module('mind/controllers/quantity_controller.pro').
:- use_module('mind/controllers/recipes_controller.pro').

:- use_module('mind/speech/interact.pro').
:- use_module('mind/speech/recipes_speech.pro').

:- use_module('mind/questions/weight/weight_questions.pro').

interpretCommand(MustBeCommand, ResultString):-
    string_lower(MustBeCommand, LowerCommand),
    re_replace("ё", "е", LowerCommand, ReplacedCommand),
    re_replace(",", "", ReplacedCommand, Command),

    format(string(ReceiveCommandMessage), "Received command for parsing: '~s'", Command),
    core_services:logDebug(ReceiveCommandMessage),

    atomic_list_concat(WordsList,' ', Command),

    parseCommand(Command, WordsList, ResultString);
    
    core_services:logDebug("Received invalid command"),
    ResultString = "".

parseCommand(_, WordsList, ResultString):-
    phrase(recipes_speech:recipes_all(RecipeNameList), WordsList),
    core_services:logDebug("Run recipes command"),
    atomics_to_string(RecipeNameList, " ", RecipeName),
    normalize_space(atom(RecipeNameNorm), RecipeName),
    recipes_controller:рецептВесь(RecipeNameNorm, RecipeContent),
    swritef(ResultString, "Ваш рецепт %w", [RecipeContent]);

    weight_questions:weightQuestion(WordsList, ResultString);
    
    phrase(interact:questionNotCorrect, AnswerList),
    atomic_list_concat(AnswerList, " ", ResultString).
    

writelnPermutations(InputString):- 
    permutation_controller:writelnPerms(InputString).
