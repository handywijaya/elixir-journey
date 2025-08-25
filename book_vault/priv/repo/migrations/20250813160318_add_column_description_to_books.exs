defmodule BookVault.Repo.Migrations.AddColumnDescriptionToBooks do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :description, :text
    end
  end
end
