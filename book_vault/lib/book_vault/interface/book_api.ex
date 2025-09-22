defmodule BookVault.BookAPI do
  @moduledoc """
  This module contains functions to render book information.
  """

  alias BookVault.Books.Book

  @doc """
  Returns the list of books.

  ## Examples

      iex> list_books()
      [%Book{}, ...]

  """
  @callback list_books() :: [%Book{}]

  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get_book!(123)
      %Book{}

      iex> get_book!(456)
      ** (Ecto.NoResultsError)

  """
  @callback get_book!(id :: String.t()) :: %Book{}

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(%{field: value})
      {:ok, %Book{}}

      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @callback create_book(attrs :: map()) :: {:ok, %Book{}} | {:error, %Ecto.Changeset{}}

  @doc """
  Updates a book.

  ## Examples

      iex> update_book(book, %{field: new_value})
      {:ok, %Book{}}

      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @callback update_book(book :: %Book{}, attrs :: map()) :: {:ok, %Book{}} | {:error, %Ecto.Changeset{}}

  @doc """
  Deletes a book.

  ## Examples

      iex> delete_book(book)
      {:ok, %Book{}}

      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}

  """
  @callback delete_book(book :: %Book{}) :: {:ok, %Book{}} | {:error, %Ecto.Changeset{}}

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.

  ## Examples

      iex> change_book(book)
      %Ecto.Changeset{data: %Book{}}

  """
  @callback change_book(book :: %Book{}, attrs :: map()) :: %Ecto.Changeset{data: %Book{}}
end
