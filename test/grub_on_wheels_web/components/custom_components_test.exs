defmodule GrubOnWheelsWeb.CustomComponentsTest do
  use GrubOnWheels.DataCase, async: true

  import Phoenix.LiveViewTest

  alias GrubOnWheelsWeb.CustomComponents

  describe "location_modal" do
    test "should include the vendor name and food items", %{location1: location} do
      html = render_component(
        &CustomComponents.location_modal/1, location: location, next: "surprise_me"
      )

      assert html =~ location.applicant
      assert html =~ "Succulent Sushi"
      assert html =~ "phx-click=\"surprise_me\""
    end
  end
end
