%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 3 DecOct 2017 by Math
%%%-------------------------------------------------------------------
-module(matrix_as_ets_bin).
-export([rows_sums/1, cols_sums/1,
         get_value/3,set_value/4,
         load/1]).

load({Width, Height, Matrix})->
    MatrixEts = ets:new(matrix,[public, set]),
    
    ets:insert(MatrixEts, {width, Width}),
    ets:insert(MatrixEts, {height, Height}),
    
    [ets:insert(MatrixEts, {<< X,Y >>, element(X+(Y-1)*Width,Matrix)}) 
     || Y<-lists:seq(1,Height), X<-lists:seq(1,Width)],
    MatrixEts.

rows_sums(MatrixEts)->
    Height = ets:lookup_element(MatrixEts, height, 2),
    PatternFun = vector_pattern_function_factory(row),
    [sum_output_values(PatternFun,  No, MatrixEts) || No <- lists:seq(1,Height)].

cols_sums(MatrixEts)->
    Width = ets:lookup_element(MatrixEts, width, 2),
    PatternFun = vector_pattern_function_factory(col),
    [sum_output_values(PatternFun,  No, MatrixEts) || No <- lists:seq(1,Width)].

sum_output_values(PatternFun, VectorIndex, MatrixEts)->
    Key = ets:first(MatrixEts),
    sum_output_values_support(PatternFun, VectorIndex, MatrixEts, Key, 0).
	
vector_pattern_function_factory(col)->
    fun(CheckBin, VectorIndex) ->
	    case CheckBin of
		<<VectorIndex, _>> -> true;      
		_ -> false              
	    end end;
vector_pattern_function_factory(row) ->
    fun(CheckBin, VectorIndex) ->
	    case CheckBin of
		<<_, VectorIndex>> -> true;      
		_ -> false              
	    end end.

sum_output_values_support(_PatternFun, _VectorIndex, _MatrixEts, '$end_of_table', Result)-> 
    Result;
sum_output_values_support(PatternFun, VectorIndex, MatrixEts, Key, Result)->
    NextKey = ets:next(MatrixEts, Key),
    case PatternFun(Key, VectorIndex) of
	true ->
	    NewResult = Result + ets:lookup_element(MatrixEts, Key, 2),
	    sum_output_values_support(PatternFun, VectorIndex, MatrixEts, NextKey, NewResult);
	false -> 
	    sum_output_values_support(PatternFun, VectorIndex, MatrixEts, NextKey, Result)
    end.

get_value(TheX, TheY, MatrixEts)->
    ets:lookup_element(MatrixEts, << TheX, TheY >>, 2).
    
set_value(TheX, TheY, NewValue, MatrixEts)->
    true = ets:insert(MatrixEts, {<< TheX, TheY >>, NewValue}),
    MatrixEts.
