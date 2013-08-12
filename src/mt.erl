-module(mt).

-export([
         init_inline/1,
         init_wrap/1,
         time_n/2
        ]).

-include_lib("mixer/include/mixer.hrl").

-mixin([{mt_base, [init/1]}]).

init_inline(X) ->
    {ok, {base, X, [], 0}}.

init_wrap(X) ->
    mt_base:init(X).

loop(_F, 0) ->
    ok;
loop(F, N) ->
    F(x),
    loop(F, N-1).

time_n(F, N) ->
    {Time, _} = timer:tc(fun() ->
                                 loop(F, N)
                         end),
    Time.

