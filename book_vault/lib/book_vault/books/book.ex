defmodule BookVault.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, except: [:__meta__]}
  schema "books" do
    field :title, :string
    field :author, :string
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :description])
    |> validate_required([:title, :author])
    |> unique_constraint([:title, :author])
  end
end
