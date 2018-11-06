%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 7 Dec 2017 by Math
%%%-------------------------------------------------------------------
-module(matrix_as_ext_bit_map).
-export([rows_sums/1, cols_sums/1,
         get_value/3,set_value/4,
         load/1]).

load({Width,Height,Matrix})->
    PropList = 
	[{
	   bitstring_trailing:coordinates_to_bits({X,Y}),
	   element(X+(Y-1)*Width, Matrix)
	 } || Y<-lists:seq(1,Height), X<-lists:seq(1,Width)],
    {Height, Width, maps:from_list(PropList)}.


rows_sums({Height, Width, Map})->
    rows_sums({Height, Width, Map}, 1).

rows_sums({Height, _Width, _Map}, HeightStop) when HeightStop==Height+1->
    [];
rows_sums({Height, Width, Map}, RowIndex)->
    RowIndexes = 
	[bitstring_trailing:coordinates_to_bits({X,RowIndex}) || X<-lists:seq(1,Width)],
    RowSubmap = maps:with(RowIndexes, Map),
    TheSum = lists:sum(maps:values(RowSubmap)),
    [TheSum | rows_sums({Height, Width, Map}, RowIndex+1)].

cols_sums({Height, Width, Map})->
    cols_sums({Height, Width, Map}, 1).

cols_sums({_Height, Width, _Map}, WidthStop) when WidthStop==Width+1->
    [];
cols_sums({Height, Width, Map}, ColIndex)->
    ColIndexes = 
	[bitstring_trailing:coordinates_to_bits({ColIndex,Y}) || Y<-lists:seq(1,Height)],
    Colsubmap = maps:with(ColIndexes, Map),
    TheSum = lists:sum(maps:values(Colsubmap)),
    [TheSum | cols_sums({Height, Width, Map}, ColIndex+1)].

get_value(TheX, TheY, {_Height, _Width, Map})->
    Index = bitstring_trailing:coordinates_to_bits({TheX, TheY}),
    maps:get(Index, Map).

set_value(TheX, TheY, NewValue, {Height, Width, Map})->
    Index = bitstring_trailing:coordinates_to_bits({TheX, TheY}),
    {Height, Width, Map#{Index:=NewValue}}.
