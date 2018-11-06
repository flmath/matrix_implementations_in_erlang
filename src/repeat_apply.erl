%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created :  9 Oct 2017 by Math 
%%%-------------------------------------------------------------------
-module(repeat_apply).

-export([on_matrix/4]).

on_matrix(_Module, _Function, _Arguments, 0)->
    ok;
on_matrix(Module, Function, [_Matrix | _ ] = Arguments, Times)->
    apply(Module,Function,Arguments),
    on_matrix(Module, Function, [_Matrix | _ ] = Arguments, Times-1).
