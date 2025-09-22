defmodule BookVault.Books do
  @behaviour BookVault.BookAPI

  @moduledoc """
  The Books context.
  """

  import Ecto.Query, warn: false
  alias BookVault.Repo

  alias BookVault.Books.Book

  @impl true
  def list_books do
    Repo.all(Book)
  end

  @impl true
  def get_book!(id), do: Repo.get!(Book, id)

  @impl true
  def create_book(attrs) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @impl true
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  @impl true
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @impl true
  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end
end
