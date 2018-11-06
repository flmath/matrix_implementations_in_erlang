%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created :  9 Oct 2017 by Math 
%%%-------------------------------------------------------------------
-module(matrix_tuple_of_tuples_tests).

-include_lib("eunit/include/eunit.hrl").

rows_sums_empty_load_test()->
    AssumedResult = {},
    ActualResult = matrix_as_tuple_of_tuples:load({0,0,{}}),
    ?assertEqual(AssumedResult, ActualResult).

rows_sums_3_by_4_load_test()->
    AssumedResult = {{2,3,11},{4,5,12},{6,7,12},{13,14,15}},
    ActualResult = matrix_as_tuple_of_tuples:load({3,4,{2,3,11,4,5,12,6,7,12,13,14,15}}),
    ?assertEqual(AssumedResult, ActualResult).

rows_sums_empty_test()->
    AssumedResult = [],
    ActualResult = matrix_as_tuple_of_tuples:rows_sums({}),
    ?assertEqual(AssumedResult, ActualResult).

rows_sums_tuple_of_tuples_one_element_test()->
    AssumedResult = [2],
    ActualResult = matrix_as_tuple_of_tuples:rows_sums({{2}}),
    ?assertEqual(AssumedResult, ActualResult).

rows_sums_tuple_of_tuples_2_by_3_element_test()->
    AssumedResult = [5,9,13],
    ActualResult = matrix_as_tuple_of_tuples:rows_sums({{2,3},{4,5},{6,7}}),
    ?assertEqual(AssumedResult, ActualResult).

cols_sums_empty_test()->
    AssumedResult = [],
    ActualResult = matrix_as_tuple_of_tuples:cols_sums({}),
    ?assertEqual(AssumedResult, ActualResult).

cols_sums_tuple_of_tuples_one_element_test()->
    AssumedResult = [2],
    ActualResult = matrix_as_tuple_of_tuples:cols_sums({{2}}),
    ?assertEqual(AssumedResult, ActualResult).

cols_sums_tuple_of_tuples_2_by_3_element_test()->
    AssumedResult = [12,15],
    ActualResult = matrix_as_tuple_of_tuples:cols_sums({{2,3},{4,5},{6,7}}),
    ?assertEqual(AssumedResult, ActualResult).

get_element_test()->
    AssumedResult = 7,
    ActualResult = matrix_as_tuple_of_tuples:get_value(2,3,{{2,3,11},{4,5,12},{6,7,12},{13,14,15}}),
    ?assertEqual(AssumedResult, ActualResult).

set_element_test()->
    AssumedResult = {{2,3,11},{4,5,12},{6,99,12},{13,14,15}},
    ActualResult = matrix_as_tuple_of_tuples:set_value(2,3,99,{{2,3,11},{4,5,12},{6,7,12},{13,14,15}}),
    ?assertEqual(AssumedResult, ActualResult).

set_front_element_test()->
    AssumedResult = {{99,3,11},{4,5,12},{6,7,12},{13,14,15}},
    ActualResult = matrix_as_tuple_of_tuples:set_value(1,1,99,{{2,3,11},{4,5,12},{6,7,12},{13,14,15}}),
    ?assertEqual(AssumedResult, ActualResult).

set_back_element_test()->
    AssumedResult = {{2,3,11},{4,5,12},{6,7,12},{13,14,99}},
    ActualResult = matrix_as_tuple_of_tuples:set_value(3,4,99,{{2,3,11},{4,5,12},{6,7,12},{13,14,15}}),
    ?assertEqual(AssumedResult, ActualResult).

set_back_mid_element_test()->
    AssumedResult = {{2,3,11},{4,5,12},{6,7,99},{13,14,15}},
    ActualResult = matrix_as_tuple_of_tuples:set_value(3,3,99,{{2,3,11},{4,5,12},{6,7,12},{13,14,15}}),
    ?assertEqual(AssumedResult, ActualResult).

full_verification_test()->
    StartMatrix = {{2,3,11},{4,5,12},{6,7,12},{13,14,15}},
    Rows = matrix_as_tuple_of_tuples:rows_sums(StartMatrix),
    ?assertEqual([16,21,25,42], Rows),
    Cols = matrix_as_tuple_of_tuples:cols_sums(StartMatrix),
    ?assertEqual([25,29,50], Cols),
    NewMatrix = matrix_as_tuple_of_tuples:set_value(2,3,50,StartMatrix),
    AssumedResult = {{2,3,11},{4,5,12},{6,50,12},{13,14,15}},
    ?assertEqual(AssumedResult, NewMatrix),
    NewRows = matrix_as_tuple_of_tuples:rows_sums(NewMatrix),
    ?assertEqual([16,21,68,42], NewRows),
    NewCols = matrix_as_tuple_of_tuples:cols_sums(NewMatrix),
    ?assertEqual([25,72,50], NewCols).
