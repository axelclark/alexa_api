use Mix.Config

config :bike_share, :capital,
  http_client: BikeShare.Test.HTTPClient
