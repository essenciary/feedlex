defmodule Feedlex do
  @moduledoc """
  Wrapper around the Feedly API
  """

  @feedly_api_host            %{sandbox: "https://sandbox.feedly.com", live: "https://cloud.feedly.com"}

  @doc """
  Getter for accessing the feedly_api_host config
  """
  def feedly_api_host do
    @feedly_api_host
  end
end
