-module(start_tracking_h).

-export([init/2]).

init(Req8, Opts) ->
    Req = cowboy_req:reply(200, #{
        <<"content-type">> => <<"text/plain">>
    }, "[\"Hello world!\"]", Req8),
    {ok, Req, Opts}.