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
:- use_module('expert/common/speech/permutations/permutation_controller.pro').

:- use_module('expert/ingredients/speech/ingredients_case.pro').
:- use_module('expert/common/speech/quantity/measure/quantity_measure.pro').
:- use_module('expert/recipes/recipes_controller.pro').

:- use_module('expert/common/speech/interact.pro').
:- use_module('expert/recipes/speech/recipes_speech.pro').

:- use_module('expert/weight/weight_questions.pro').
:- use_module('expert/info/info_questions.pro').

:- use_module('expert/operating/operating_db.pro').

interpretCommand(MustBeCommand, ResultString):-
    string_lower(MustBeCommand, LowerCommand),
    re_replace("ё", "е", LowerCommand, ReplacedCommand),
    re_replace(",", "", ReplacedCommand, Command),

    % TODO revmoe from commands
    operating_db:load,

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
    info_questions:infoAbout(WordsList, ResultString);
    
    phrase(interact:questionNotCorrect, AnswerList),
    atomic_list_concat(AnswerList, " ", ResultString).
    

writelnPermutations(InputString):- 
    permutation_controller:writelnPerms(InputString).
