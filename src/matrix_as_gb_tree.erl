%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 10 Oct 2017 by Math
%%%-------------------------------------------------------------------
-module(matrix_as_gb_tree).
-export([rows_sums/1, cols_sums/1,
         get_value/3,set_value/4,
         load/1]).

load({Width,Height,Matrix})->
    PropList = 
	[{{X, Y}, element(X+(Y-1)*Width, Matrix)} || Y<-lists:seq(1,Height),X<-lists:seq(1,Width)],
    gb_trees:from_orddict(
      orddict:from_list(
	lists:append([{height,Height},{width,Width}], PropList))).

rows_sums({0,0,_})-> [];
rows_sums(Tree)->
    Height = gb_trees:get(height, Tree),
    Width = gb_trees:get(width, Tree),
    rows_sums(Tree,1,Height,Width).

rows_sums(_, HeightStop, Height,_) when HeightStop==Height+1->
    [];
rows_sums(Tree, RowIndex, Height, Width)->
    RowIndexes = [{X,RowIndex} || X<-lists:seq(1,Width)],
    TheSum = sum(RowIndexes,Tree),
    [TheSum | rows_sums(Tree, RowIndex+1, Height, Width)].

cols_sums({0,0,_})-> [];
cols_sums(Tree)->
    Height = gb_trees:get(height, Tree),
    Width = gb_trees:get(width, Tree),
    cols_sums(Tree,1,Width,Height).

cols_sums(_, WidthStop, Width,_) when WidthStop==Width+1->
    [];
cols_sums(Tree, ColIndex, Width,Height)->
    ColIndexes = [{ColIndex,Y} || Y<-lists:seq(1,Height)],
    TheSum = sum(ColIndexes,Tree),
    [TheSum | cols_sums(Tree, ColIndex+1, Width, Height)].

sum(RowIndexes,Tree)->
    sum(RowIndexes,Tree,0).

sum([],_Tree,Sum)-> Sum;
sum([Index|RowIndexes],Tree,Sum)->
    Value = gb_trees:get(Index, Tree),
    sum(RowIndexes,Tree,Value+Sum).

get_value(TheX, TheY, Tree)->
    gb_trees:get({TheX,TheY},Tree).

set_value(TheX, TheY, NewValue, Tree)->
    gb_trees:enter({TheX,TheY}, NewValue, Tree).
