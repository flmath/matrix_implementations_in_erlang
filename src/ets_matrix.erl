-module(ets_matrix).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point

main([Module, Function, "range", 
      MatrixMinSize, SizeStep, MatrixMaxSize, 
      RunsNoMin, RunsNoStep, RunsNoMax]) ->
    lists:foreach(
      fun({Size, RunsNo})-> 
	      main([Module, Function, integer_to_list(Size), 
		    integer_to_list(Size), integer_to_list(RunsNo)])
      end, 
      [{S,R}  ||
	  R<-lists:seq(list_to_integer(RunsNoMin),
		       list_to_integer(RunsNoMax),
		       list_to_integer(RunsNoStep)),
	  S<-lists:seq(list_to_integer(MatrixMinSize),
		       list_to_integer(MatrixMaxSize),
		       list_to_integer(SizeStep))]);
main([Module, "all", MatrixWidth, MatrixHeight, RunsNo]) ->
    lists:foreach(
      fun(Fun)-> 
	      main([Module, Fun, MatrixWidth, MatrixHeight, RunsNo])
      end, 
      list_of_exec_functions()); 
main(["all", Function, MatrixWidth, MatrixHeight, RunsNo]) ->
    lists:foreach(
      fun(Mod)-> 
	      main([Mod, Function, MatrixWidth, MatrixHeight, RunsNo])
      end, 
      list_of_matrix_forms());    
main([Module, Function, MatrixWidth, MatrixHeight, RunsNo]) ->
    {Result, ok} = 
	try  
	    wrapper_expected_time_estimation_run(
	      Module, Function, MatrixWidth, MatrixHeight, RunsNo)
	catch
	    Mod:Error ->
		io:format("~p~n",[[Mod,Error]]),
		usage()
	end,
    print_result(Module, Function, MatrixWidth, MatrixHeight, RunsNo, Result);
main(_) ->
    usage().
%%====================================================================
%% Internal functions
%%====================================================================
wrapper_expected_time_estimation_run(Module, Function, MatrixWidth, MatrixHeight, RunsNo)->
    expected_time_estimation:run(
      list_to_atom(Module), 
      list_to_atom(Function), 
      list_to_integer(MatrixWidth),
      list_to_integer(MatrixHeight), 
      list_to_integer(RunsNo)).

print_result(Module, Function, MatrixWidth, MatrixHeight, RunsNo, Result)->
    io:format("{Representation: ~p, "
	      "Operation: ~p, "
	      "Width: ~p, "
	      "Height: ~p, "
	      "Runs: ~p, "
	      "ExecutionTime: ~p}~n",
	      [Module, Function, MatrixWidth, MatrixHeight, RunsNo, Result]).


usage()->
    io:format(
      "usage:"
      "ets_matrix Module, Function, MatrixWidth, MatrixHeight, Number of runs \n"
      "ets_matrix Module, Function, \"range\" \"Min matrix size\" \"Increase step\", \"Max matrix size,\" "
      "\"Min no of runs\" \"No of runs increase step\", \"Max no of runs\" \n"
      "Module ex.  all\n"),
    lists:foreach(
      fun(Name)-> io:format("~p~n",[list_to_atom(Name)]) end,
      list_of_matrix_forms()),
    io:format("Function ex.  all\n"),
    lists:foreach(
      fun(Name)-> io:format("~p~n",[list_to_atom(Name)]) end,
      list_of_exec_functions()),
    io:format("MatrixWidth, MatrixHeight, the number of runs are integers\n"
              "examples:"
	      "ets_matrix matrix_as_map get_value 1000 1000 1000 \n"
	      "ets_matrix matrix_as_map get_value range 10 10 100 10 10 100 \n"
	      "ets_matrix all all 10 100 100 \n"
	     ,[]).

list_of_matrix_forms()->
    [
     "matrix_as_bit_map",
     "matrix_as_ext_bit_map",
     "matrix_as_digraph",
     "matrix_as_ets_bin",
     "matrix_as_map",   
     "matrix_as_list_map",
     "matrix_as_array",
     "matrix_as_ets",
     "matrix_as_big_tuple",
     "matrix_as_ets_list",
     "matrix_as_tuple_of_tuples",
     "matrix_as_array_of_arrays",
     "matrix_as_dict",
     "matrix_as_orddict",
     "matrix_as_gb_tree",
     "matrix_as_list_of_lists",
     "matrix_as_sofs"
    ].

list_of_exec_functions()->
    [
     "get_value",
     "set_value",
     "rows_sums",
     "cols_sums"
    ].
