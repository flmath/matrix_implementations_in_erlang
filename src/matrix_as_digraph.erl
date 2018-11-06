%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created : 10 Oct 2017 by Math
%%%-------------------------------------------------------------------
-module(matrix_as_digraph).

-export([rows_sums/1, cols_sums/1,
         get_value/3,set_value/4,
         load/1]).

load({Width,Height,Matrix})->
    MatrixDigraph = digraph:new(),
    digraph:add_vertex(MatrixDigraph, width, Width),
    digraph:add_vertex(MatrixDigraph, height, Height),

    [digraph:add_vertex(MatrixDigraph,{col,No})|| No<-lists:seq(1,Width)],
    [digraph:add_vertex(MatrixDigraph,{row,No})|| No<-lists:seq(1,Height)],
    
    [digraph:add_vertex(MatrixDigraph, {X,Y}, element(X+(Y-1)*Width,Matrix)) 
     || Y<-lists:seq(1,Height), X<-lists:seq(1,Width)],
    
    [digraph:add_edge(MatrixDigraph, {X,Y}, {row,Y}) 
     || Y<-lists:seq(1,Height), X<-lists:seq(1,Width)],
    [digraph:add_edge(MatrixDigraph, {X,Y}, {col,X}) 
     || Y<-lists:seq(1,Height), X<-lists:seq(1,Width)],
    MatrixDigraph.

rows_sums(Digraph)->
    {height,Height} = digraph:vertex(Digraph,height),
    [sum_output_values({row,No},Digraph) || No <- lists:seq(1,Height)].

cols_sums(Digraph)->
    {width,Width} = digraph:vertex(Digraph,width),
    [sum_output_values({col,No},Digraph) || No <- lists:seq(1,Width)].

sum_output_values(AggregatorIndex,Digraph)->
    AggregatedVerticles = digraph:in_neighbours(Digraph,AggregatorIndex), 
    lists:sum([Output || 
                  Verticle <- AggregatedVerticles, 
                  {_X_Y, Output}<-[digraph:vertex(Digraph,Verticle)]]).

get_value(TheX, TheY, Digraph)->
    {_X_Y, Output} = digraph:vertex(Digraph,{TheX, TheY}),
    Output.
    
set_value(TheX, TheY, NewValue, Digraph)->
    digraph:add_vertex(Digraph, {TheX,TheY}, NewValue),
    Digraph.
