defmodule GrubOnWheelsWeb.LocationsLiveTest do
  use GrubOnWheelsWeb.ConnCase, async: true

  import Phoenix.ConnTest
  import Phoenix.LiveViewTest

  test "Locations: connected mount", %{conn: conn} do
    {:ok, _view, html} = live(conn, "/")

    assert html =~ "Welcome to Grub on Wheels!"
  end
end
