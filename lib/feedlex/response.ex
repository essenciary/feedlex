defmodule Feedlex.Response do
  @moduledoc """
  Utility functions for dealing with Feedly API responses
  """

  @doc """
  Parses the raw Feedly API response into a common format
  """
  def parse(response) do
    if Map.has_key?(response, :status_code) do
      case response.status_code do
        200 ->
          {:ok, Poison.Parser.parse!(response.body)}
        _ ->
          {:ko, Poison.Parser.parse!(response.body)}
      end
    else
      {:ko, response}
    end
  end
end
