defmodule Feedlex.Request do
  @moduledoc """
  Utility module for handling request related functionality
  """

  require Logger

  @doc """
  Makes a GET request to a feedly API, with header authentication
  """
  def get(opts \\ %{}) do
    Logger.info "GET: Requesting from #{Feedlex.feedly_api_host[opts[:env] || :sandbox] <> opts[:api_endpoint]}"

    HTTPoison.start
    HTTPoison.get!(Feedlex.feedly_api_host[opts[:env] || :sandbox] <> opts[:api_endpoint],
                      [{"Authorization", "OAuth #{opts[:access_token]}"}])
    |> Feedlex.Response.parse
  end

  def post(opts \\ %{}) do
    Logger.info "POST: Requesting from #{Feedlex.feedly_api_host[opts[:env] || :sandbox] <> opts[:api_endpoint]}"

    HTTPoison.start
    HTTPoison.post!(Feedlex.feedly_api_host[opts[:env] || :sandbox] <> opts[:api_endpoint],
                    opts[:payload], [{"Authorization", "OAuth #{opts[:access_token]}"}])
    |> Feedlex.Response.parse
  end
end
