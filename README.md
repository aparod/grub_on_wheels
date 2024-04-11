# GrubOnWheels

Hello, and thanks for taking the time to look over my code!  It was a fun little project.

My idea was to create an application that makes finding a place to eat fun.  It does this by filtering locations in various ways and then suggesting a random one.

The app lets you choose a location, and displays how many times you have visited it.

## Thoughts and Implementation Notes

- I spent time ensuring `seeds.exs` was as performant as possible.  The data is streamed, decoded, chunked, processed asynchronously, and ultimately persisted using `Ecto.Multi` bulk inserts.

- If I had more time, I would have liked to add the ability to browse a list of locations, and also do more with the visit count (like letting the user know which places have become their most frequented, etc).

## Limitations

- Of course, a real app would need the concept of users.  Visits to locations would become a join table between locations and users.

- I ran out of time to do much UI testing, but I tried to get at least a few tests in place.

## Installation

Note: The app requires Elixir/Erlang and PostgreSQL.  If you don't have them installed, `asdf install` can get you up and running quickly.

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
