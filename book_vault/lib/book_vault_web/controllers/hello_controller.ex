defmodule BookVaultWeb.HelloController do
  use BookVaultWeb, :controller

  def index(conn, _params) do
    json(conn, %{message: "Hello from BookVault!"})
  end
end
