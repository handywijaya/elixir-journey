defmodule BookVault.Repo.Migrations.AddUniqueToBooks do
  use Ecto.Migration

  def change do
    create unique_index(:books, [:title, :author])
  end
end
