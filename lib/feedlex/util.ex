defmodule Feedlex.Util do
  @moduledoc """
  Generic utility functions for Pocketex
  """

  @doc """
  Converts an option name from Elixir's underscore_notation to Pocket's bumpyCase
  """
  @spec underscore_to_bumpy(String.t) :: String.t

  def underscore_to_bumpy(string) when is_bitstring(string) do
    [head|tail] = String.split(string, "_")
    rest = Enum.map_join(tail, &(String.capitalize &1) )

    head <> rest
  end

  def underscore_to_bumpy(atom) when is_atom(atom) do
    atom |> to_string |> underscore_to_bumpy
  end
end
