%%%-------------------------------------------------------------------
%% @doc tracking public API
%% @end
%%%-------------------------------------------------------------------

-module(tracking_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
           {"/", store_package_info_h, []}
        ]}
    ]),

PrivDir = code:priv_dir(tracking),
{ok,_} = cowboy:start_tls(https_listener, [
    {port, 443},
    {certfile, PrivDir ++ "/ssl/fullchain.pem"},
    {keyfile, PrivDir ++ "/ssl/privkey.pem"}
    ], #{env => #{dispatch => Dispatch}}),
tracking_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
