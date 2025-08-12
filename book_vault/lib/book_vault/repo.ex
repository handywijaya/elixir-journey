defmodule BookVault.Repo do
  use Ecto.Repo,
    otp_app: :book_vault,
    adapter: Ecto.Adapters.Postgres
end
