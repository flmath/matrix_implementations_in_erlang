%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created :  9 Oct 2017 by Math 
%%%-------------------------------------------------------------------
-module(expected_time_estimation_tests).

-include_lib("eunit/include/eunit.hrl").

prepare_empty_test()->
    AssumedResult = #{height=>0,width=>0},
    ActualResult = expected_time_estimation:prepare_matrix(matrix_as_map, 0, 0),
    ?assertEqual(AssumedResult, ActualResult).

prepare_basic_test()->
    AssumedResult = #{{1,1}=>1,{1,2}=>3,{1,3}=>5,
                      {2,1}=>2,{2,2}=>4,{2,3}=>6, 
                      height=>3,width=>2},
     ActualResult = expected_time_estimation:prepare_matrix(matrix_as_map,2,3),
     ?assertEqual(AssumedResult, ActualResult).

prepare_argumets_basic_test()->
    AssumedResult = [1,1,#{{1,1}=>1,{1,2}=>3,{1,3}=>5,
                      {2,1}=>2,{2,2}=>4,{2,3}=>6, 
                      height=>3,width=>2}],
    Matrix = expected_time_estimation:prepare_matrix(matrix_as_map,2,3),
    ActualResult = expected_time_estimation:prepare_arguments(Matrix, 2, 3, get_value),
    ?assertEqual(AssumedResult, ActualResult).
