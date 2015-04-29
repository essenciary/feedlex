defmodule Feedlex.Feed do
  @moduledoc """
  Wrapper around the Feedly Feeds API
  https://developer.feedly.com/v3/feeds/
  """
  @feedly_feeds_uri   "/v3/feeds"

  @doc """
  Return meta-data about a specific feed
  """
  def one(opts \\ %{}) do
    Feedlex.Request.get(api_endpoint: @feedly_feeds_uri <> "/" <> opts[:feed_id], access_token: opts[:access_token])
  end

  @doc """
  Returns meta data for a list of feeds
  """
  def many(opts \\ %{}) do
    Feedlex.Request.post(api_endpoint: @feedly_feeds_uri <> "/.mget", access_token: opts[:access_token], payload: Poison.encode!(opts[:feeds]))
  end
end
