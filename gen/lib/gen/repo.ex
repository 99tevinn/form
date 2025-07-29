defmodule Gen.Repo do
  use Ecto.Repo,
    otp_app: :gen,
    adapter: Ecto.Adapters.Postgres
end
