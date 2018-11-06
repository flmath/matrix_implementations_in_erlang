## matrix_implementations_in_erlang

The erlang and OTP are lacking explicite matrix support.
This is a little study of possible implementations for matrixes in Erlang.
Every implementation contains rows_sum/1, cols_sum/1, get_value/3 and set_value/4 functions.

Results
-----

[Jupyter notebook research](https://nbviewer.jupyter.org/urls/gitlab.com/erlang_matrices/matrix_implementations_in_erlang/raw/master/jupyter/main.ipynb)

Build
-----
You can use the local rebar or a rebar3 installed in your system

$ local_rebar/rebar3 clean

I added small script to remove artifacts

$ clean.sh

To tests we need escript created from ets_matrix.app.src

$ local_rebar/rebar3 escriptize

It is good to check if everything is ok with eunit (I\ve tried to follow TDD during implementation)

$ local_rebar/rebar3 eunit

Run
---
$range.sh  <size_from> <size_to> <size_step> <no_of_runs_from> <no_of_runs_to> <no_of_runs_step>

is equal to:

$ _build/default/bin/ets_matrix all all range <size_from> <size_step> <size_to> <no_of_runs_from> <no_of_runs_step> <no_of_runs_to>

but usage of _build/default/bin/ets_matrix _ _ range is discuraged since can end with error

[error,system_limit]

 =ERROR REPORT==== 20-Sep-2018::18:56:28 ===
 
** Too many db tables **

for more options just run 

_build/default/bin/ets_matrix 

to get description.

example:

$ range.sh  10 100 10 10 10 10

$ range.sh  10 100 10 10 100 10