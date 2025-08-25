defmodule BookVault.Repo.Migrations.AddIndexToBooksTitle do
  use Ecto.Migration

  def change do
    create index(:books, [:title])
  end
end
