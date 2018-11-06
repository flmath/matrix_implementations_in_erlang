%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 7 Dec 2017 by Math
%%%-------------------------------------------------------------------
-module(matrix_as_bit_map).
-export([rows_sums/1, cols_sums/1,
         get_value/3,set_value/4,
         load/1]).

load({Width,Height,Matrix})->
    PropList = 
	[{
	   bitstring_trailing:coordinates_to_bits({X,Y}),
	   element(X+(Y-1)*Width, Matrix)
	 } || Y<-lists:seq(1,Height), X<-lists:seq(1,Width)],
    
    maps:from_list(lists:append(
		     [{height, Height}, {width, Width}], PropList)).

rows_sums({0,0,_})-> [];
rows_sums(Map)->
    #{height:=Height, width:=Width}=Map,
    rows_sums(Map, 1, Height, Width).

rows_sums(_, HeightStop, Height, _) when HeightStop==Height+1->
    [];
rows_sums(Map, RowIndex, Height, Width)->
    RowIndexes = 
	[bitstring_trailing:coordinates_to_bits({X, RowIndex}) || X<-lists:seq(1,Width)],
    RowSubmap = maps:with(RowIndexes, Map),
    TheSum = lists:sum(maps:values(RowSubmap)),
    [TheSum | rows_sums(Map, RowIndex+1, Height, Width)].

cols_sums({0,0,_})-> [];
cols_sums(Map)->
    #{height:=Height, width:=Width}=Map,
    cols_sums(Map, 1, Width, Height).

cols_sums(_, WidthStop, Width, _) when WidthStop==Width+1->
    [];
cols_sums(Map, ColIndex, Width, Height)->
    ColIndexes = 
	[bitstring_trailing:coordinates_to_bits({ColIndex,Y}) || Y<-lists:seq(1,Height)],
    Colsubmap = maps:with(ColIndexes, Map),
    TheSum = lists:sum(maps:values(Colsubmap)),
    [TheSum | cols_sums(Map, ColIndex+1, Width, Height)].

get_value(TheX, TheY, Map)->
    Index = bitstring_trailing:coordinates_to_bits({TheX,TheY}),
    maps:get(Index, Map).

set_value(TheX, TheY, NewValue, Map)->
    Index = bitstring_trailing:coordinates_to_bits({TheX,TheY}),
    Map#{Index:=NewValue}.
