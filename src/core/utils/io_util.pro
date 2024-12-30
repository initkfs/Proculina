/**
@author initkfs
*/
:- module(io_util, [
    dirRegularFiles/2
    ]).

:- use_module(library(apply)).

dirFileList([]).

dirRegularFiles(DirectoryPathString, DirFilesArray):-
    absolute_file_name(DirectoryPathString, DirectoryFullPath),
    directory_files(DirectoryFullPath, Files),
    exclude(=('.'), Files, DirFilesWithoutCurrent),
    exclude(=('..'), DirFilesWithoutCurrent, FileNames),
    length(FileNames, FilesCount),
    FilesCount > 0,
    length(ParentPaths, FilesCount),
    maplist(=(DirectoryFullPath), ParentPaths),
    maplist(buildPathForDir, ParentPaths, FileNames, DirFilesArray);
    DirFilesArray = [].

buildPathForDir(DirPathString, FileNameString, ResultPathString):-
    string_concat(DirPathString, "/", NormalizedDirString),
    string_concat(NormalizedDirString, FileNameString, ResultPathString).
