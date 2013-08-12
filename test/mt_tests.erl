%% Copyright 2012 Opscode, Inc. All Rights Reserved.
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%

-module(mt_tests).

-include_lib("eunit/include/eunit.hrl").

mt_test_() ->
    {setup,
     fun() ->
             ok
     end,
     fun(_) ->
             ok
     end,
     [
      {"mixer timing",
       fun() ->
               Expect = {ok, {base, x, [], 0}},
               ?assertEqual(Expect, mt:init_inline(x)),
               ?assertEqual(Expect, mt:init_wrap(x)),
               ?assertEqual(Expect, mt:init(x)),

               %% Time `Reps' calls and use the inline version as the baseline.
               Reps = 50000,
               TInitInline = mt:time_n(fun mt:init_inline/1, Reps),
               TInit = mt:time_n(fun mt:init/1, Reps),
               TInitWrap = mt:time_n(fun mt:init_wrap/1, Reps),
               ?debugFmt("\nRELATIVE\ninit: ~.2f\ninit_wrap: ~.2f\n",
                         [TInit / TInitInline, TInitWrap / TInitInline]),
               AbsDiff = fun(X) ->
                                 (X - TInitInline) / (Reps * 1.0)
                         end,
               ?debugFmt("\nABSOLUTE microsecs per call\ninit: ~.3f\ninit_wrap: ~.3f\n",
                         [AbsDiff(TInit), AbsDiff(TInitWrap)])

       end}
      ]}.

