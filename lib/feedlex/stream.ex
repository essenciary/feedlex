defmodule Feedlex.Stream do
  @moduledoc """
  Wrapper around the Feedly Streams API
  https://developer.feedly.com/v3/streams/
  """

  @feedly_streams_uri   "/v3/streams"

  @doc """
  Gets the content of a stream
  """
  def content(opts \\ %{}) do
    uri = @feedly_streams_uri <> "/" <> opts[:feed_id] <> "/contents?"

    params = for {k, v} <- (opts[:filters] || %{}), into: "", do: Feedlex.Util.underscore_to_bumpy(k) <> "=#{v}&"

    Feedlex.Request.get(api_endpoint: uri <> params,
                        access_token: opts[:access_token])
  end
end
