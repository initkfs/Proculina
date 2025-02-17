/** <module>
@author initkfs
*/
:- module(operating_db, [

]).

memfilePath(Path):- Path = "src/domain/expert/operating/db.pro".

load():-
    memfilePath(MemFile),
    load_files(MemFile).

writeDmModule(Stream):- write(Stream, ":- module(operating_db_store, []).\n").

reset():-
    memfilePath(MemFile),
    open(MemFile,write,Stream),
    writeDmModule(Stream),
    with_output_to(Stream, listing(operating_db_store:_)),
    % seek(Stream, 0, bof,  _),
    close(Stream).

saveWidthStream(StreamFunc):-
    memfilePath(MemFile),
    open(MemFile,write,Stream),
    writeDmModule(Stream),
    call(StreamFunc, Stream),
    close(Stream).