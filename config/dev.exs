use Mix.Config

# whether or not the app runs in sandbox mode
config :feedly, sandbox: true
config :feedly, client_id: "sandbox"
config :feedly, client_secret: "4205DQXBAP99S8SUHXI3" # (expires on 6/1/2015)
config :feedly, redirect_uri: "http://localhost:8080/" # don't forget the closing "/"
