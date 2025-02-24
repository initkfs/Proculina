/** <module>
@author initkfs
*/
:- module(operating_db, [

]).

:- use_module('./../../../../core/core_services.pro').

memfilePath(Path):- 
    core_services:getConfigValue(domainConfigOperatingDbFile, Path).

load:-
    memfilePath(MemFile),
    load_files(MemFile).

writeDbModule(Stream):- write(Stream, ":- module(operating_db_store, []).\n").

reset:-
    memfilePath(MemFile),
    open(MemFile,write,Stream),
    writeDbModule(Stream),
    with_output_to(Stream, listing(operating_db_store:_)),
    % seek(Stream, 0, bof,  _),
    close(Stream).

saveWidthStream(StreamFunc):-
    memfilePath(MemFile),
    open(MemFile, write, Stream),
    writeDbModule(Stream),
    call(StreamFunc, Stream),
    close(Stream).