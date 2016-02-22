defmodule Feedlex.Auth do
  @moduledoc """
  Exposes authentication and authorization functions into the Feedly API
  https://developer.feedly.com/v3/auth/
  """

  @feedly_auth_uri            "/v3/auth/auth"
  @feedly_auth_token_uri      "/v3/auth/token"
  @request_headers_json       [{"Content-Type", "application/json; charset=UTF-8"}, {"X-Accept", "application/json"}]

  @doc """
  Returns the complete URI for beginning the authentication and authorization
  process in the browser.
  The client should redirect the user to the returned URI
  """
  def authenticate_uri(opts \\ %{}) do
    uri = Feedlex.feedly_api_host[opts[:env] || :sandbox] <> @feedly_auth_uri <> "?" <>
            "response_type=#{opts[:response_type] || "code"}" <> "&" <>
            "client_id=#{opts[:client_id] || Application.get_env(:feedlex, :client_id)}" <> "&" <>
            "redirect_uri=#{URI.encode_www_form(opts[:redirect_uri] || Application.get_env(:feedlex, :redirect_uri))}" <> "&" <>
            "scope=#{opts[:scope] || "https://cloud.feedly.com/subscriptions"}"
    unless is_nil(opts[:state]), do: uri = uri <> "&state=#{URI.encode_www_form(opts[:state])}"

    uri
  end

  @doc """
  Exchanges the received Feedly authentication code for a refresh token and
  an access token
  """
  def access_token(opts \\ %{}) do
    payload = ~s"""
    {
      "code":"#{opts[:code]}",
      "client_id":"#{opts[:client_id] || Application.get_env(:feedlex, :client_id)}",
      "client_secret":"#{opts[:client_secret] || Application.get_env(:feedlex, :client_secret)}",
      "state":"#{URI.encode_www_form(opts[:state] || "")}",
      "grant_type":"#{opts[:grant_type] || "authorization_code"}"
    }
    """

    uri = Feedlex.feedly_api_host[opts[:env] || :sandbox] <> @feedly_auth_token_uri <> "?" <>
            "redirect_uri=#{URI.encode_www_form(opts[:redirect_uri] || Application.get_env(:feedlex, :redirect_uri))}"

    HTTPoison.start
    HTTPoison.post!(uri, payload, @request_headers_json)
    |> Feedlex.Response.parse
  end

  @doc """
  Uses the refresh token to ask for a new access token
  """
  def refresh_access_token(opts \\ %{}) do
    payload = ~s"""
    {
      "refresh_token":"#{opts[:refresh_token]}",
      "client_id":"#{opts[:client_id] || Application.get_env(:feedlex, :client_id)}",
      "client_secret":"#{opts[:client_secret] || Application.get_env(:feedlex, :client_secret)}",
      "grant_type":"refresh_token"
    }
    """

    uri = Feedlex.feedly_api_host[opts[:env] || :sandbox] <> @feedly_auth_token_uri

    HTTPoison.start
    HTTPoison.post!(uri, payload, @request_headers_json)
    |> Feedlex.Response.parse
  end

  @doc """
    Logoff - revokes the access and refresh tokens
  """
  def revoke_token(opts \\ %{}) do
    payload = ~s"""
    {
      "refresh_token":"#{opts[:refresh_token]}",
      "client_id":"#{opts[:client_id] || Application.get_env(:feedlex, :client_id)}",
      "client_secret":"#{opts[:client_secret] || Application.get_env(:feedlex, :client_secret)}",
      "grant_type":"revoke_token"
    }
    """

    uri = Feedlex.feedly_api_host[opts[:env] || :sandbox] <> @feedly_auth_token_uri

    HTTPoison.start
    HTTPoison.post!(uri, payload, @request_headers_json)
    |> Feedlex.Response.parse
  end

end
