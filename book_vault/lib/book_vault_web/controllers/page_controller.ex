defmodule BookVaultWeb.PageController do
  use BookVaultWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end
end
