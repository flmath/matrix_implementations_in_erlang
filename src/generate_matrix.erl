%%%-------------------------------------------------------------------
%%% @author Math
%%% @copyright (C) 2017, Math
%%% @doc
%%%
%%% @end
%%% Created :  9 Oct 2017 by Math 
%%%-------------------------------------------------------------------
-module(generate_matrix).

-export([arithmetic_sum/2]).

arithmetic_sum(0,0)->
    {{0, 0, {}},[], []};
arithmetic_sum(Width,Height)->
    Matrix = list_to_tuple(lists:seq(1,Width*Height)),
    SumFromOneToWidth = (Width * (Width + 1)) div 2,
    RowsSums = lists:seq(SumFromOneToWidth,
                         SumFromOneToWidth + Width * Width * (Height - 1),
                         Width * Width),

    SumFromOneToHeight = Height +  Width * ((Height * (Height - 1)) div 2),
    ColsSums = lists:seq(SumFromOneToHeight,
                         SumFromOneToHeight + (Width-1) * Height,
                         Height),

    {{Width, Height, Matrix}, ColsSums, RowsSums}.  

