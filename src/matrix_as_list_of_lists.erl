%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 10 Oct 2017 by Math
%%%-------------------------------------------------------------------
-module(matrix_as_list_of_lists).

-export([rows_sums/1, cols_sums/1,
         get_value/3,set_value/4, 
         load/1]).

load({Width,Height,Matrix})->
    [[element(X+(Y-1)*Width, Matrix) 
      || X<-lists:seq(1,Width)
     ]|| Y<-lists:seq(1,Height)].

rows_sums(Matrix) ->
    [lists:sum(Row)|| Row <- Matrix].

cols_sums([]) -> [];
cols_sums([[]|_]) -> [];
cols_sums(Matrix) ->
    {Heads, Tails} = lists:unzip([{Head,Tail} || [Head| Tail]<- Matrix]),
    [lists:sum(Heads)| cols_sums(Tails)].

get_value(X, Y, Matrix)->
    Row = lists:nth(Y, Matrix),
    lists:nth(X, Row).

set_value(X, Y, NewValue, Matrix)->
    {PrecedingList,[Row | TailList]} = lists:split(Y-1, Matrix),
    {PrecedingElements,[_OldValue | TailElements]} = lists:split(X-1,Row),
    lists:append([PrecedingList,
                 [lists:append([PrecedingElements,[NewValue], TailElements])],
                 TailList]).
