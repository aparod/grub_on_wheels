defmodule GrubOnWheelsWeb.LocationsLive do
  use GrubOnWheelsWeb, :live_view

  import GrubOnWheelsWeb.CustomComponents

  alias GrubOnWheels.Locations
  alias GrubOnWheels.Locations.Location

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(next_action: nil)
      |> assign(location: %Location{})
      |> assign(form: to_form(%{"search" => "", "type" => "food_items"}))

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.header class="pb-8 border-b-2">
      Welcome to Grub on Wheels!
      <:subtitle>For those who like to chase down their meals</:subtitle>
    </.header>

    <h1 class="py-12">What are you in the mood for today?</h1>

    <div class="grid grid-cols-1 gap-4">
      <div>
        <.button phx-click="surprise_me" class="w-full">
          I'm up for anything... surprise me!
        </.button>
      </div>
      <div>
        <.button phx-click="someplace_new" class="w-full">
          Send me someplace new
        </.button>
      </div>
      <div>
        <.simple_form
          for={@form}
          phx-submit="filter"
        >
          I'm feeling choosy:

          <div class="flex flex-row gap-4">
            <div class="basis-1/2">
              <.input
                field={@form[:search]}
                required
              />
            </div>
            <div class="basis-1/4">
              <.input
                field={@form[:type]}
                type="select"
                options={[{"Type of Food", "food_items"}, {"Vendor", "applicant"}]}
              />
            </div>
            <div class="basis-1/4 pt-1">
              <.button class="w-full">Search</.button>
            </div>
          </div>
        </.simple_form>
      </div>
    </div>

    <.location_modal location={@location} next={@next_action} />
    """
  end

  def handle_event("surprise_me", _unsigned_params, socket) do
    location = Locations.list() |> Enum.take_random(1) |> Enum.at(0)

    socket =
      socket
      |> assign(next_action: "surprise_me")
      |> assign(location: location)
      |> push_event("toggle_location", %{attr: "data-show"})

    {:noreply, socket}
  end

  def handle_event("someplace_new", _unsigned_params, socket) do
    location = Locations.list(new: true) |> Enum.take_random(1) |> Enum.at(0)

    socket =
      case location do
        nil ->
          socket
          |> put_flash(:error, "You have already visited every location!")
          |> push_event("toggle_location", %{attr: "data-hide"})

        _ ->
          socket
          |> assign(next_action: "someplace_new")
          |> assign(location: location)
          |> push_event("toggle_location", %{attr: "data-show"})
      end

    {:noreply, socket}
  end

  # The food item/vendor form uses this event handler when submitted.
  def handle_event("filter", %{"type" => type, "search" => search}, socket) do
    filter =
      case type do
        "food_items" -> [food_items: search]
        "applicant" -> [applicant: search]
      end

    location = Locations.list(filter) |> Enum.take_random(1) |> Enum.at(0)

    socket =
      case location do
        nil ->
          socket
          |> put_flash(:error, "No matching locations")
          |> push_event("toggle_location", %{attr: "data-hide"})

        _ ->
          socket
          |> assign(next_action: "filter")
          |> assign(filter: filter)
          |> assign(location: location)
          |> push_event("toggle_location", %{attr: "data-show"})
      end

    {:noreply, socket}
  end

  # The modal window uses this event handler when it was opened as a result
  # of the food/vendor form being submitted.
  def handle_event("filter", _params, socket) do
    filter = socket.assigns.filter
    location = Locations.list(filter) |> Enum.take_random(1) |> Enum.at(0)

    socket =
      case location do
        nil ->
          socket
          |> put_flash(:error, "No matching locations")
          |> push_event("toggle_location", %{attr: "data-hide"})

        _ ->
          socket
          |> assign(location: location)
          |> push_event("toggle_location", %{attr: "data-show"})
      end

    {:noreply, socket}
  end

  def handle_event("choose_location", _params, socket) do
    socket =
      case Locations.visit(socket.assigns.location.id) do
        {:ok, _location} ->
          socket
          |> put_flash(:info, "Enjoy your meal at #{socket.assigns.location.applicant}!")
          |> push_event("toggle_location", %{attr: "data-hide"})

        {:error, _} ->
          socket
          |> put_flash(:error, "Unable to update your visit count")
          |> push_event("toggle_location", %{attr: "data-hide"})
      end

    {:noreply, socket}
  end
end
