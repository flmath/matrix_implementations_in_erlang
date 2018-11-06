%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 10 Oct 2017 by Math
%%%-------------------------------------------------------------------
-module(matrix_as_orddict).
-export([rows_sums/1, cols_sums/1,
         get_value/3,set_value/4,
         load/1]).

load({Width,Height,Matrix})->
    PropList = 
	[{{X, Y}, element(X+(Y-1)*Width, Matrix)} || Y<-lists:seq(1,Height),X<-lists:seq(1,Width)],
    orddict:from_list(lists:append([{height,Height},{width,Width}], PropList)).

rows_sums({0,0,_})-> [];
rows_sums(Dict)->
    Height = orddict:fetch(height, Dict),
    Width = orddict:fetch(width, Dict),
    rows_sums(Dict,1,Height,Width).

rows_sums(_, HeightStop, Height,_) when HeightStop==Height+1->
    [];
rows_sums(Dict, RowIndex, Height, Width)->
    RowIndexes = [{X,RowIndex} || X<-lists:seq(1,Width)],
    TheSum = sum(RowIndexes,Dict),
    [TheSum | rows_sums(Dict, RowIndex+1, Height, Width)].

cols_sums({0,0,_})-> [];
cols_sums(Dict)->
    Height = orddict:fetch(height, Dict),
    Width = orddict:fetch(width, Dict),
    cols_sums(Dict,1,Width,Height).

cols_sums(_, WidthStop, Width,_) when WidthStop==Width+1->
    [];
cols_sums(Dict, ColIndex, Width,Height)->
    ColIndexes = [{ColIndex,Y} || Y<-lists:seq(1,Height)],
    TheSum = sum(ColIndexes,Dict),
    [TheSum | cols_sums(Dict, ColIndex+1, Width, Height)].

sum(RowIndexes,Dict)->
    sum(RowIndexes,Dict,0).

sum([],_Dict,Sum)-> Sum;
sum([Index|RowIndexes],Dict,Sum)->
    Value = orddict:fetch(Index, Dict),
    sum(RowIndexes,Dict,Value+Sum).

get_value(TheX, TheY, Dict)->
    orddict:fetch({TheX,TheY},Dict).

set_value(TheX, TheY, NewValue, Dict)->
    orddict:store({TheX,TheY}, NewValue, Dict).
