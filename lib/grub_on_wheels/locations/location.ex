defmodule GrubOnWheels.Locations.Location do
  use Ecto.Schema

  @type t() :: %__MODULE__{
    locationid: binary(),
    applicant: binary(),
    facility_type: binary(),
    address: binary(),
    food_items: binary(),
    schedule: binary(),
    visits: integer()
  }

  schema "locations" do
    field :locationid, :string
    field :applicant, :string
    field :facility_type, :string
    field :address, :string
    field :food_items, :string
    field :schedule, :string
    field :visits, :integer
  end
end
