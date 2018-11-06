%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created :  9 Oct 2017 by Math 
%%%-------------------------------------------------------------------
-module(matrix_as_map_tests).

-include_lib("eunit/include/eunit.hrl").

load_empty_test()->
    AssumedResult = #{height=>0,width=>0},
    ActualResult = matrix_as_map:load({0,0,{}}),
    ?assertEqual(AssumedResult, ActualResult).

load_basic_test()->
    AssumedResult = #{{1,1}=>2,{1,2}=>4,{1,3}=>6,
                      {2,1}=>3,{2,2}=>5,{2,3}=>7, 
                      height=>3,width=>2},
     ActualResult = matrix_as_map:load({2,3,{2,3,4,5,6,7}}),
     ?assertEqual(AssumedResult, ActualResult).

rows_sums_empty_test()->
    AssumedResult = [],
    Input = matrix_as_map:load({0,0,{}}),
    ActualResult = matrix_as_map:rows_sums(Input),
    ?assertEqual(AssumedResult, ActualResult).

rows_sums_list_of_lists_one_element_test()->
    Input = matrix_as_map:load({1,1,{2}}),
    AssumedResult = [2],
    ActualResult = matrix_as_map:rows_sums(Input),
    ?assertEqual(AssumedResult, ActualResult).

rows_sums_list_of_lists_2_by_3_element_test()->
    Input = matrix_as_map:load({2,3,{2,3,4,5,6,7}}),
    AssumedResult = [5,9,13],
    ActualResult = matrix_as_map:rows_sums(Input),
    ?assertEqual(AssumedResult, ActualResult).

cols_sums_empty_test()->
    Input = matrix_as_map:load({0,0,{}}),
    AssumedResult = [],
    ActualResult = matrix_as_map:cols_sums(Input),
    ?assertEqual(AssumedResult, ActualResult).

cols_sums_list_of_lists_one_element_test()->
    Input = matrix_as_map:load({1,1,{2}}),
    AssumedResult = [2],
    ActualResult = matrix_as_map:cols_sums(Input),
    ?assertEqual(AssumedResult, ActualResult).

cols_sums_list_of_lists_2_by_3_element_test()->
    Input = matrix_as_map:load({2,3,{2,3,4,5,6,7}}),
    AssumedResult = [12,15],
    ActualResult = matrix_as_map:cols_sums(Input),
    ?assertEqual(AssumedResult, ActualResult).

get_element_test()->
    Input = matrix_as_map:load({3,4,{2,3,11,4,5,12,6,7,12,13,14,15}}),
    AssumedResult = 7,
    ActualResult = matrix_as_map:get_value(2,3,Input),
    ?assertEqual(AssumedResult, ActualResult).

set_element_test()->
    Input = matrix_as_map:load({3,4,{2,3,11,4,5,12,6,7,12,13,14,15}}),
    AssumedResult = matrix_as_map:load({3,4,{2,3,11,4,5,12,6,99,12,13,14,15}}),
    ActualResult = matrix_as_map:set_value(2,3,99,Input),
    ?assertEqual(AssumedResult, ActualResult).

set_front_element_test()->
    Input = matrix_as_map:load({3,4,{2,3,11,4,5,12,6,7,12,13,14,15}}),
    AssumedResult = matrix_as_map:load({3,4,{99,3,11,4,5,12,6,7,12,13,14,15}}),
    ActualResult = matrix_as_map:set_value(1,1,99,Input),
    ?assertEqual(AssumedResult, ActualResult).

set_back_element_test()->
    Input = matrix_as_map:load({3,4,{2,3,11,4,5,12,6,7,12,13,14,15}}),
    AssumedResult = matrix_as_map:load({3,4,{2,3,11,4,5,12,6,7,12,13,14,99}}),
    ActualResult = matrix_as_map:set_value(3,4,99,Input),
    ?assertEqual(AssumedResult, ActualResult).

set_back_mid_element_test()->
    Input = matrix_as_map:load({3,4,{2,3,11,4,5,12,6,7,12,13,14,15}}),
    AssumedResult =  matrix_as_map:load({3,4,{2,3,11,4,5,12,6,7,99,13,14,15}}),
    ActualResult = matrix_as_map:set_value(3,3,99,Input),
    ?assertEqual(AssumedResult, ActualResult).

full_verification_test()->
    StartMatrix = matrix_as_map:load({3,4,{2,3,11,4,5,12,6,7,12,13,14,15}}),
    Rows = matrix_as_map:rows_sums(StartMatrix),
    ?assertEqual([16,21,25,42], Rows),
    Cols = matrix_as_map:cols_sums(StartMatrix),
    ?assertEqual([25,29,50], Cols),
    NewMatrix = matrix_as_map:set_value(2,3,50,StartMatrix),
    AssumedResult =matrix_as_map:load({3,4,{2,3,11,4,5,12,6,50,12,13,14,15}}),
    ?assertEqual(AssumedResult, NewMatrix),
    NewRows = matrix_as_map:rows_sums(NewMatrix),
    ?assertEqual([16,21,68,42], NewRows),
    NewCols = matrix_as_map:cols_sums(NewMatrix),
    ?assertEqual([25,72,50], NewCols).
