%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 10 Oct 2017 by Math
%%%-------------------------------------------------------------------
-module(matrix_as_array_of_arrays).

-export([rows_sums/1, cols_sums/1,
         get_value/3,set_value/4, 
         load/1]).

load({Width,Height,Matrix})->
    ArraysMatrix = 
	array:from_list(
	  [array:from_list([element(X+(Y-1)*Width, Matrix) 
			    || X<-lists:seq(1,Width)])
	   || Y<-lists:seq(1,Height)]),
    ArraysMatrix.

rows_sums(Matrix) -> rows_sums(Matrix, array:size(Matrix)). 

rows_sums(_Matrix,0) -> [];
rows_sums(Matrix,Size) -> rows_sums(Matrix,Size-1,[]).

rows_sums(_Matrix,-1,Acc) -> Acc; 
rows_sums(Matrix,Index,Acc) -> 
    rows_sums(Matrix,Index-1,
	      [row_sum(array:get(Index,Matrix))|Acc]).

row_sum(Row)->
    array:foldl(fun(_,X,Acc) -> X+Acc end, 0,Row).

cols_sums(Matrix) -> cols_sums(Matrix, array:size(Matrix)).

cols_sums(_Matrix,0) -> [];
cols_sums(Matrix,Height) -> 
    
    Width = array:size(array:get(0,Matrix)),
    cols_sums(Matrix,Height-1, Width-1, []).

cols_sums(_Matrix,_Height, -1,Acc) -> Acc;
cols_sums(Matrix,Heigth,Index,Acc) ->
    cols_sums(Matrix,Heigth,Index-1,[col_sum(Matrix,Heigth,Index)|Acc]).

col_sum(Matrix,RowNo,ColNo)->
    col_sum(Matrix,RowNo,ColNo,0).

col_sum(_Matrix,-1,_ColNo,ColSum)->
    ColSum;
col_sum(Matrix,RowNo,ColNo,ColSum)->
    Row = array:get(RowNo,Matrix),
    col_sum(Matrix,RowNo-1,ColNo, array:get(ColNo,Row)+ColSum).

get_value(X, Y, Matrix)->
    Row = array:get(Y-1, Matrix),
    array:get(X-1, Row).

set_value(X, Y, NewValue, Matrix)->
    Row = array:get(Y-1, Matrix),
    NewRow = array:set(X-1, NewValue,Row),
    array:set(Y-1,NewRow,Matrix).
