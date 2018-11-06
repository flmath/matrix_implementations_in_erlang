%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 3 Dec 2017 by Math
%%%-------------------------------------------------------------------
-module(bitstring_trailing).
-export([compress/1,
	 coordinates_to_bits/1]).

compress(Integer)->
    BitsList = [<<X/bitstring>> || <<X:1/bitstring>> <= binary:encode_unsigned(Integer)],
    TrimmedBitsList =  lists:dropwhile(fun(X) -> X == <<0:1>> end, BitsList),
    << <<X/bitstring>> || <<X:1/bitstring>> <- TrimmedBitsList >>.

coordinates_to_bits({X,Y}) ->
    X_bit = compress(X),
    Y_bit = binary:encode_unsigned(Y),
    <<X_bit/bitstring, Y_bit/bitstring>>.
