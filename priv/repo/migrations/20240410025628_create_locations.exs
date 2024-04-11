defmodule GrubOnWheels.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :locationid, :text, null: false
      add :applicant, :text, null: false
      add :facility_type, :text, null: false
      add :address, :text, null: false
      add :food_items, :text, null: false
      add :schedule, :text, null: false
      add :visits, :integer, null: false, default: 0
    end
  end
end
