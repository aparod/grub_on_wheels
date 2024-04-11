# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GrubOnWheels.Repo.insert!(%GrubOnWheels.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias GrubOnWheels.Locations.Location

headers = ~W(
  locationid applicant facility_type cnn location_description address blocklot
  block lot permit status food_items x y latitude longitude schedule dayshours
  noi_sent approved received prior_permit expiration_date location
  fire_prevention_districts police_districts supervisor_districts zip_codes
  neighborhoods_old
)a

keys = ~W(locationid applicant facility_type address food_items schedule)a

File.stream!("./data/data.csv")
|> CSV.decode!(headers: headers)
|> Stream.chunk_every(25)
|> Enum.map(fn chunk ->
  Task.async(fn ->
    locations = Enum.map(chunk, &Map.take(&1, keys))

    Ecto.Multi.new()
    |> Ecto.Multi.insert_all(:insert_all, Location, locations)
    |> GrubOnWheels.Repo.transaction()
  end)
end)
|> Task.await_many()
