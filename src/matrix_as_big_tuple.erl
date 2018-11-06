%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 10 Oct 2017 by Math
%%%-------------------------------------------------------------------
-module(matrix_as_big_tuple).

-export([load/1,
	 rows_sums/1, cols_sums/1,
         get_value/3,set_value/4]).

load(Matrix)-> 
    Matrix.
    
rows_sums({_Width,_Height,{}}) ->[];
rows_sums({Width,Height,Matrix}) ->
    rows_sums({Width,Height,Matrix},0,[]).

rows_sums({_Width,Height,_Matrix},RowNo,_Acc) when Height==RowNo->
    [];
rows_sums({Width,Height,Matrix},RowNo,Acc) ->
    RowSum = lists:sum(
               [element(Index, Matrix)|| Index <- lists:seq(RowNo*Width+1,(RowNo+1)*Width)]),
    [RowSum|rows_sums({Width,Height,Matrix},RowNo+1,Acc)].

cols_sums({_Width,_Height,{}}) ->[];
cols_sums({Width,Height,Matrix}) ->
    cols_sums({Width,Height,Matrix},0,[]).

cols_sums({Width,_Height,_Matrix},ColNo,_Acc) when Width==ColNo->
    [];
cols_sums({Width,Height,Matrix},ColNo,Acc) ->
    ColSum = lists:sum(
               [element(Index, Matrix)|| 
		   Index <- lists:seq(ColNo+1,ColNo+(Width*(Height-1))+1,Width)]),
    
    [ColSum | cols_sums({Width,Height,Matrix},ColNo+1,Acc)].

get_value(X, Y,{Width,_Height,Matrix})->
    element((Y-1)*Width+X,Matrix).
    
set_value(X, Y, NewValue, {Width,Height,Matrix})->
   {Width,Height, setelement((Y-1)*Width+X, Matrix,NewValue)}.
