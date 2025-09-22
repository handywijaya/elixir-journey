defmodule BookVaultWeb.LibraryLive do
  use Phoenix.LiveView
  import BookVaultWeb.BackgroundComponent
  import BookVaultWeb.HeaderComponent
  import BookVaultWeb.FooterComponent

  @impl true
  def mount(_params, _session, socket) do
    books = fetch_books()
    {:ok,
      assign(socket,
        books: books,
        message: nil,
        form: %{"title" => "", "author" => "", "description" => ""}
      )
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.background />
    <.header page="library" />
    <div class="bg-gray-100">
      <div class="flex flex-row pb-4">
        <div class="flex-1 p-6 pt-0">
          <.add_book_form message={@message} form={@form}/>
        </div>
        <div class="flex-1 p-6 pt-0">
          <.book_list books={@books} />
        </div>
      </div>
    </div>
    <.footer />
    """
  end

  defp add_book_form(assigns) do
    ~H"""
    <form
      phx-submit="add_book"
      phx-change="change_form"
      class="space-y-4 bg-white rounded shadow p-6"
    >
      <h2 class="text-xl font-bold mb-2">Add New Book</h2>
      <%= if @message do %>
        <%= if @message.type == :info do %>
          <div class="bg-blue-100 text-blue-700 px-4 py-2 rounded mb-2">
            <%= @message.text %>
          </div>
        <% else %>
          <%= if @message.type == :error do %>
            <div class="bg-red-100 text-red-700 px-4 py-2 rounded mb-2">
              <%= @message.text %>
            </div>
          <% end %>
        <% end %>
      <% end %>
      <div>
        <label class="block text-sm font-medium mb-1" for="title">Title</label>
        <input type="text" id="title" name="form[title]" value={@form["title"]} class="w-full border rounded px-3 py-2" />
      </div>
      <div>
        <label class="block text-sm font-medium mb-1" for="author">Author</label>
        <input type="text" id="author" name="form[author]" value={@form["author"]} class="w-full border rounded px-3 py-2" />
      </div>
      <div>
        <label class="block text-sm font-medium mb-1" for="description">Description</label>
        <input type="text" id="description" name="form[description]" value={@form["description"]} class="w-full border rounded px-3 py-2" />
      </div>
      <button type="submit" class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded">
        Add Book
      </button>
    </form>
    """
  end

  defp book_list(assigns) do
    ~H"""
    <ul>
      <li :for={book <- @books} class="mb-4 p-4 bg-white rounded shadow">
        <div class="font-semibold text-lg">{book["title"]}</div>
        <div class="text-gray-600">{book["author"]}</div>
        <div class="text-gray-500 text-sm">{book["description"]}</div>
      </li>
    </ul>
    """
  end

  defp fetch_books do
    url = "http://localhost:4000/api/books"
    case Req.get(url) do
      {:ok, response} ->
        case response.status do
          200 -> response.body
          _ -> []
        end
      _ -> []
    end
  end

  @impl true
  def handle_event("change_form", %{"form" => form}, socket) do
    {:noreply, assign(socket, form: form)}
  end

  # TODO: add unit test for thermostat and library live view
  @impl true
  def handle_event("add_book", %{"form" => params}, socket) do
    url = "http://localhost:4000/api/books"
    body = %{"book" => params}
    socket = assign(socket, message: %{type: :info, text: "Adding book..."})

    case Req.post(url, json: body) do
      {:ok, response} ->
        IO.puts(inspect(response, label: "Response"))
        case response.status do
          200 ->
            {:noreply,
              assign(socket,
                books: fetch_books(),
                form: %{"title" => "", "author" => "", "description" => ""},
                message: %{type: :info, text: "Book added successfully!"}
              )
            }
          _ ->
            error_message =
              case response.body["errorMessage"] do
                list when is_list(list) -> Enum.join(list, ", ")
                other -> to_string(other)
              end
            {:noreply, assign(socket, message: %{type: :error, text: "Failed to add book: #{error_message}"})}
        end
      {:error, reason} ->
        {:noreply, assign(socket, message: %{type: :error, text: "Failed to add book: #{reason}"})}
      _ ->
        {:noreply, assign(socket, message: %{type: :error, text: "Failed to add book: unknown error"})}
      end
  end
end
