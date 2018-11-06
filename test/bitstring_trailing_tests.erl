%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created :  9 Oct 2017 by Math 
%%%-------------------------------------------------------------------
-module(bitstring_trailing_tests).

-include_lib("eunit/include/eunit.hrl").

zero_compress_test()->
    AssumedResult = <<>>,
    ActualResult =  bitstring_trailing:compress(0),
    ?assertEqual(AssumedResult, ActualResult).

one_compress_test()->
    AssumedResult = <<1:1>>,
    ActualResult =  bitstring_trailing:compress(1),
    ?assertEqual(AssumedResult, ActualResult).

two_compress_test()->
     AssumedResult = <<2:2>>,
     ActualResult =  bitstring_trailing:compress(2),
     ?assertEqual(AssumedResult, ActualResult).

three_compress_test()->
    AssumedResult = <<3:2>>,
    ActualResult =  bitstring_trailing:compress(3),
    ?assertEqual(AssumedResult, ActualResult).

four_compress_test()->
    AssumedResult = <<4:3>>,
    ActualResult =  bitstring_trailing:compress(4),
    ?assertEqual(AssumedResult, ActualResult).

thousand_compress_test()->
    AssumedResult = << 1000:10 >>,%1111101000
    ActualResult =  bitstring_trailing:compress(1000),
    ?assertEqual(AssumedResult, ActualResult).

thousand_one_compress_test()->
     AssumedResult = <<1001:10>>,%1111101001
     ActualResult =  bitstring_trailing:compress(1001),
     ?assertEqual(AssumedResult, ActualResult).

thousand_25_compress_test()->
    AssumedResult = << 1025:11 >>,%10000000000
    ActualResult =  bitstring_trailing:compress(1025),
    ?assertEqual(AssumedResult, ActualResult).

eight_thousand_compress_test()->
     AssumedResult = <<8193:14>>,%10000000000000
     ActualResult =  bitstring_trailing:compress(8193),
    ?assertEqual(AssumedResult, ActualResult).


zero_coord_test()->
    AssumedResult = <<0>>,
    ActualResult =  bitstring_trailing:coordinates_to_bits({0,0}),
    ?assertEqual(AssumedResult, ActualResult).

one_coordinates_to_bits_test()->
    AssumedResult = <<1:1,0:8>>,
    ActualResult =  bitstring_trailing:coordinates_to_bits({1,0}),
    ?assertEqual(AssumedResult, ActualResult).

two_coordinates_to_bits_test()->
     AssumedResult = <<1:1,1:8>>,
     ActualResult =  bitstring_trailing:coordinates_to_bits({1,1}),
     ?assertEqual(AssumedResult, ActualResult).

three_coordinates_to_bits_test()->
    AssumedResult = <<1:1,3:8>>,
    ActualResult =  bitstring_trailing:coordinates_to_bits({1,3}),
    ?assertEqual(AssumedResult, ActualResult).

thousand_coordinates_to_bits_test()->
    AssumedResult = <<66536:17>>,%10000001111101000
    ActualResult =  bitstring_trailing:coordinates_to_bits({1,1000}),
    ?assertEqual(AssumedResult, ActualResult).


