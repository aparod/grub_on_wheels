defmodule GrubOnWheelsWeb.CustomComponents do
  use Phoenix.Component

  import GrubOnWheelsWeb.CoreComponents

  alias GrubOnWheels.Locations.Location

  attr :location, Location, required: true
  attr :next, :string, required: true

  def location_modal(assigns) do
    ~H"""
    <div
      id="location-modal-wrapper"
      data-show={show_modal("location-modal")}
      data-hide={hide_modal("location-modal")}
    >
      <.modal id="location-modal">
        <div class="text-2xl font-bold pb-8">
          <%= @location.applicant %>
        </div>
        <div class="grid grid-cols-1 gap-4">
          <div><span class="font-bold">Address:</span> <%= @location.address %></div>
          <div><span class="font-bold">Food types:</span> <%= @location.food_items %></div>
          <%!-- <div>
            <span class="font-bold">Schedule:</span>
            <a href={@location.schedule} class="underline" target="_blank">Click to view</a>
          </div> --%>
          <div class="mb-4">
            <span class="font-bold">Visits:</span> <%= @location.visits %>
          </div>
          <div>
            <.button phx-click="choose_location" class="w-full">Choose</.button>
          </div>
          <div>
            <.button phx-click={@next} class="w-full">Next Location</.button>
          </div>
          <div>
            <.button
              phx-click={hide_modal("location-modal")}
              class="w-full bg-red-600 hover:bg-red-500"
            >
              Never mind
            </.button>
          </div>
        </div>
      </.modal>
    </div>
    """
  end
end
