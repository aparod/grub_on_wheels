defmodule GrubOnWheels.Locations do
  @moduledoc """
  The context for working with `Locations`.
  """

  import Ecto.Query

  alias GrubOnWheels.Locations.Location
  alias GrubOnWheels.Repo

  @doc """
  By default, returns all `Locations` in the database.  Results can be filtered
  by food_items and applicant, or limited to those locations that have not been
  visited yet.

  Examples:

  list()                           # Returns everything
  list(food_items: "tacos")        # Returns locations that sell tacos
  list(applicant: "Munch A Bunch") # Returns all locations for Munch A Bunch
  list(new: true)                  # Returns locations with a visit count of 0
  """
  @spec list(keyword()) :: list(Location.t())
  def list(filters \\ []) do
    query = from(Location)

    query =
      if filters[:food_items],
        do: from(l in query, where: ilike(l.food_items, ^"%#{filters[:food_items]}%")),
        else: query

    query =
      if filters[:applicant],
        do: from(l in query, where: ilike(l.applicant, ^"%#{filters[:applicant]}%")),
        else: query

    query =
      if filters[:new],
        do: from(l in query, where: l.visits == 0),
        else: query

    Repo.all(query)
  end

  @doc """
  Increments the visit count for the specified location.
  """
  @spec visit(integer()) :: {:ok, Location.t()} | {:error, any()}
  def visit(id) do
    with %Location{} = location <- Repo.get(Location, id) do
      Ecto.Changeset.change(location, %{visits: location.visits + 1})
      |> Repo.update()
    else
      nil -> {:error, :not_found}
    end
  end
end
