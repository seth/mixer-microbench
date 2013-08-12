-module(mt_base).

-export([init/1]).
%-compile({inline, [init/1]}).
init(X) ->
    {ok, {base, X, [], 0}}.

    
