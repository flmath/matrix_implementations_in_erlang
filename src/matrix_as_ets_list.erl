%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 3 DecOct 2017 by Math
%%%-------------------------------------------------------------------
-module(matrix_as_ets_list).
-export([rows_sums/1, cols_sums/1,
         get_value/3,set_value/4,
         load/1]).

load({Width, Height, Matrix})->
    MatrixEts = ets:new(matrix,[public, set]),
    
    ets:insert(MatrixEts, {width, Width}),
    ets:insert(MatrixEts, {height, Height}),
    
    [ets:insert(MatrixEts, {[X,Y], element(X+(Y-1)*Width,Matrix)}) 
     || Y<-lists:seq(1,Height), X<-lists:seq(1,Width)],
    MatrixEts.

rows_sums(MatrixEts)->
    Height = ets:lookup_element(MatrixEts, height, 2),
    [sum_output_values(['_', No], MatrixEts) || No <- lists:seq(1,Height)].

cols_sums(MatrixEts)->
    Width = ets:lookup_element(MatrixEts, width, 2),
    [sum_output_values([No, '_'], MatrixEts) || No <- lists:seq(1,Width)].

sum_output_values(KeyPattern, MatrixEts)->
    lists:sum([Output || [Output] <- 
			   ets:match(MatrixEts, {KeyPattern, '$1'})]).

get_value(TheX, TheY, MatrixEts)->
    ets:lookup_element(MatrixEts, [TheX, TheY], 2).
    
set_value(TheX, TheY, NewValue, MatrixEts)->
    true = ets:insert(MatrixEts, {[TheX, TheY], NewValue}),
    MatrixEts.
