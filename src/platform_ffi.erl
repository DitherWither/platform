-module(platform_ffi).
-export([runtime/0, os/0, arch/0]).

runtime() -> unicode:characters_to_binary("erlang").

os() ->
    ArchitectureString = erlang:system_info(system_architecture),
    Tokens = string:tokens(ArchitectureString, "-"),
    unicode:characters_to_binary(
        case length(Tokens) of
            4 -> lists:nth(3, Tokens);
            3 -> lists:nth(3, Tokens);
            2 -> lists:nth(2, Tokens)
        end
    ).

arch() ->
    ArchitectureString = erlang:system_info(system_architecture),
    [CpuArch | _] = string:tokens(ArchitectureString, "-"),
    unicode:characters_to_binary(CpuArch).
