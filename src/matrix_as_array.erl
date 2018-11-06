%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 10 Oct 2017 by Math
%%%-------------------------------------------------------------------
-module(matrix_as_array).

-export([rows_sums/1, cols_sums/1,
         get_value/3,set_value/4,
         load/1]).

load({Width,Height,Matrix})->
   {Width,Height,array:from_list(tuple_to_list(Matrix))}.

rows_sums({0,0,_Matrix}) -> [];
rows_sums({Width,Height,Matrix}) -> rows_sums({Width,Height,Matrix}, 0,[]).

rows_sums({_Width,Height,_Matrix},RowNo,_Acc) when Height==RowNo->
    [];
rows_sums({Width,Height,Matrix},RowNo,Acc) ->
    RowSum = lists:sum(
               [array:get(Index, Matrix)|| Index <- lists:seq(RowNo*Width,(RowNo+1)*Width-1)]),
    [RowSum | rows_sums({Width,Height,Matrix},RowNo+1,Acc)].

cols_sums({_Width,_Height,{}}) ->[];
cols_sums({Width,Height,Matrix}) ->
    cols_sums({Width,Height,Matrix},0,[]).

cols_sums({Width,_Height,_Matrix},ColNo,_Acc) when Width==ColNo->
    [];
cols_sums({Width,Height,Matrix},ColNo,Acc) ->
    ColSum = lists:sum(
               [array:get(Index, Matrix)|| Index <- lists:seq(ColNo,ColNo+(Width*(Height-1)),Width)]),
    [ColSum | cols_sums({Width,Height,Matrix},ColNo+1,Acc)].

get_value(X, Y,{Width,_Height,Matrix})->
    array:get((Y-1)*Width+X-1,Matrix).
    
set_value(X, Y, NewValue, {Width,Height,Matrix})->
   {Width,Height, array:set((Y-1)*Width+X-1, NewValue, Matrix)}.
