defmodule GrubOnWheels.Repo do
  use Ecto.Repo,
    otp_app: :grub_on_wheels,
    adapter: Ecto.Adapters.Postgres
end
