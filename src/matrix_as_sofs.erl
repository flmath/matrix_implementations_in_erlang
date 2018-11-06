%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 10 Oct 2017 by Math
%%%-------------------------------------------------------------------
-module(matrix_as_sofs).

-export([rows_sums/1, cols_sums/1,
         get_value/3,set_value/4,
         load/1]).

load({Width,Height,Matrix})->
    RelAsList = [{X, Y, element(X+(Y-1)*Width, Matrix)} || 
		    Y<-lists:seq(1,Height),X<-lists:seq(1,Width)],
    sofs:relation(RelAsList).

rows_sums({_,[],_}) ->
    [];
rows_sums(Relation)->
    Partition = sofs:to_external(sofs:partition(2,Relation)),
    [sum_output_values(EquivalenceClass) || EquivalenceClass <- Partition].

cols_sums({_,[],_}) ->
    [];
cols_sums(Relation)->
    Partition = sofs:to_external(sofs:partition(1,Relation)),
    [sum_output_values(EquivalenceClass) || EquivalenceClass <- Partition].

sum_output_values(Part)->
     lists:sum([Output|| {_X, _Y, Output} <- Part]).

get_value(TheX, TheY, Relation)->
    [{TheX, TheY, Value}] = 
        sofs:to_external(
          sofs:specification(
            {external, fun({X, Y, _Output})-> (TheX==X) and (TheY==Y) end}, Relation)),
    Value.

set_value(TheX, TheY, NewValue, Relation)->
    RemovedXY = sofs:specification(
                  {external, fun({X, Y, _Output})-> (TheX=/=X) or (TheY=/=Y) end}, Relation),
    NewValueRel = sofs:relation([{TheX, TheY, NewValue}]),
    sofs:union(RemovedXY, NewValueRel).
