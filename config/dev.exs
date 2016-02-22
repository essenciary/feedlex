use Mix.Config

# whether or not the app runs in sandbox mode
config :feedlex, sandbox: true
config :feedlex, client_id: "sandbox"
config :feedlex, client_secret: "JSSBD6FZT72058P51XEG" # (expires on 4/1/2016)
config :feedlex, redirect_uri: "http://localhost:8080/" # don't forget the closing "/"
