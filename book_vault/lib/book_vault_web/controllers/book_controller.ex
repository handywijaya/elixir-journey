defmodule BookVaultWeb.BookController do
  use BookVaultWeb, :controller
  alias BookVault.Books

  def index(conn, _args) do
    conn
    |> json(Books.list_books())
  end

  def create(conn, %{"book" => book_params}) do
    case Books.create_book(book_params) do
      {:ok, book} ->
        json(conn, %{message: "Book created successfully!", book: book})
      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> json(%{
          errorCode: "validation_failed",
          errorMessage: traverse_errors(changeset)
        })
    end
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    try do
      book = Books.get_book!(id)

      case Books.update_book(book, book_params) do
        {:ok, updated_book} ->
          json(conn, %{message: "Book updated successfully!", book: updated_book})
        {:error, changeset} ->
          conn
          |> put_status(:bad_request)
          |> json(%{
            errorCode: "validation_failed",
            errorMessage: traverse_errors(changeset)
          })
      end
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_status(:not_found)
        |> json(%{errorCode: "BOOK_NOT_FOUND", errorMessage: "Book not found"})
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      book = Books.get_book!(id)

      case Books.delete_book(book) do
        {:ok, deleted_book} ->
          json(conn, %{message: "Book #{deleted_book.id} deleted successfully!"})
        {:error, changeset} ->
          conn
          |> put_status(:bad_request)
          |> json(%{
            errorCode: "Error cannot delete book",
            errorMessage: traverse_errors(changeset)
          })
      end
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_status(:not_found)
        |> json(%{errorCode: "BOOK_NOT_FOUND", errorMessage: "Book not found"})
    end
  end

  defp traverse_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
