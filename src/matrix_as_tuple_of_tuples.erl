%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 10 Oct 2017 by Math
%%%-------------------------------------------------------------------
-module(matrix_as_tuple_of_tuples).

-export([rows_sums/1, cols_sums/1,
         get_value/3,set_value/4, 
         load/1]).

load({Width,Height,Matrix})->
    TuplesMatrix = 
	list_to_tuple(
	  [list_to_tuple([element(X+(Y-1)*Width, Matrix) 
			  || X<-lists:seq(1,Width)])
	   || Y<-lists:seq(1,Height)]),
    TuplesMatrix.
rows_sums({}) -> [];
rows_sums(Matrix)->
    AnyRow = element(1,Matrix),
    rows_sums_for_ext_matrix({tuple_size(AnyRow),tuple_size(Matrix),Matrix}).

rows_sums_for_ext_matrix({Width,Height,Matrix}) ->
   rows_sums_for_ext_matrix({Width,Height,Matrix},Height,[]).
rows_sums_for_ext_matrix({_Width,_Height,_Matrix},0,Acc)->
    Acc;
rows_sums_for_ext_matrix({Width,Height,Matrix},Y,Acc)->
    Row = element(Y, Matrix),
    rows_sums_for_ext_matrix({Width,Height,Matrix},Y-1,
	      [tuple_sum(Row, Width)|Acc]).

tuple_sum(Row,Width)->
    tuple_sum(Row, Width,0).
tuple_sum(_Row,0,CurrentSum)->
    CurrentSum;
tuple_sum(Row,ElementIdx,CurrentSum)->
    tuple_sum(Row,ElementIdx-1, CurrentSum + element(ElementIdx,Row)).

cols_sums({}) -> [];
cols_sums(Matrix) -> 
    AnyRow = element(1,Matrix),
    cols_sums_for_ext_matrix({tuple_size(AnyRow),tuple_size(Matrix),Matrix}).

cols_sums_for_ext_matrix({Width,Height,Matrix}) ->
    cols_sums_for_ext_matrix({Width,Height,Matrix},Width,[]).

cols_sums_for_ext_matrix({_Width,_Height,_Matrix},0,ColsAcc)->
    ColsAcc;
cols_sums_for_ext_matrix({Width,Height,Matrix},ColNo,ColsAcc)->
    ColSum = col_sum({Width,Height,Matrix},ColNo,Height,0),
    cols_sums_for_ext_matrix({Width,Height,Matrix},ColNo-1,[ColSum | ColsAcc]).

col_sum({_Width,_Height,_Matrix},_ColNo,0,ColSum)->
    ColSum;
col_sum({Width,Height,Matrix},ColNo,RowNo,ColSum)->
    Row = element(RowNo,Matrix),
    col_sum({Width,Height,Matrix},ColNo,RowNo-1, element(ColNo,Row)+ColSum).

get_value(X, Y, Matrix)->
    Row = element(Y, Matrix),
    element(X, Row).

set_value(X, Y, NewValue, Matrix)->
    Row = element(Y, Matrix),
    NewRow = setelement(X, Row, NewValue),
    setelement(Y, Matrix, NewRow).
