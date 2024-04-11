defmodule GrubOnWheels.LocationsTest do
  use GrubOnWheels.DataCase

  alias GrubOnWheels.Locations

  describe "list/1" do
    test "should return all locations when unfiltered" do
      locations = Locations.list()

      assert 2 == length(locations)
    end

    test "should return relevant locations when filtered by food item" do
      locations = Locations.list(food_items: "sushi")
      assert 1 == length(locations)

      locations = Locations.list(food_items: "escargot")
      assert 0 == length(locations)
    end

    test "should return relevant locations when filtered by applicant" do
      locations = Locations.list(applicant: "Succulent")
      assert 1 == length(locations)

      locations = Locations.list(applicant: "Moldy")
      assert 0 == length(locations)
    end

    test "should return relevant locations when filtered by new" do
      locations = Locations.list(new: true)
      assert 1 == length(locations)
    end
  end

  describe "visit/1" do
    test "should increment the visit count of a location", %{location1: location} do
      assert location.visits == 0

      {:ok, updated_location} = Locations.visit(location.id)

      assert updated_location.visits == 1
    end

    test "should return not found for a bad location id" do
      {:error, :not_found} = Locations.visit(-1)
    end
  end
end
