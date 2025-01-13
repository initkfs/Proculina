:- module(main_domain, [

]).

:- use_module('./../core/utils/app_util.pro').
:- use_module('app.pro').
:- use_module('main_command_interpreter.pro').

:- use_module(library(optparse)).

defaultCliString(StrAtom):- StrAtom = '""'.

domainOptSpec([
    %Domain commands
    [opt(cliCommandFlag), 
        type(atom), 
        default('""'),
        shortflags([c]), 
        longflags([command]), 
        help(['Natural language command for interpretation.'])
    ],

    [opt(cliPermutationFlag), 
        type(atom), 
        default('""'),
        shortflags([p]), 
        longflags([perm]), 
        help('Generate permutations to simplify testing.')
    ]
]).

initCli(_, CliSpec, AllCliSpec):-
    domainOptSpec(DomainCliSpec),
    append(CliSpec, DomainCliSpec, AllCliSpec).

initApp(_, Logger, Config, I18n):- 
    app:initApp(Logger, Config, I18n).

runApp(Opts, _, _, _):-
    memberchk(cliPermutationsFlag(Command), Opts),
    main_command_interpreter:writelnPermutations(Command),
    app_util:exitApp;
    
    memberchk(cliCommandFlag(Command), Opts),
    atom_length(Command, CmdLen),
    CmdLen > 0,
    defaultCliString(DefaultStringAtom),
    Command \== DefaultStringAtom,
    main_command_interpreter:interpretCommand(Command, ResultString),
    writeln(ResultString),
    app_util:exitApp;

    writeln(user_error, "Application failed to start"),
    app_util:exitApp.