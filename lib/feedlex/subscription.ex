defmodule Feedlex.Subscription do
  @moduledoc """
  Wrapper around the Feedly Subscriptions API
  https://developer.feedly.com/v3/subscriptions/
  """

  @feedly_subscriptions_uri   "/v3/subscriptions"

  @doc """
  Get all subscriptions
  """
  def all(opts \\ %{}) do
    Feedlex.Request.get(api_endpoint: @feedly_subscriptions_uri, access_token: opts[:access_token])
  end
end
