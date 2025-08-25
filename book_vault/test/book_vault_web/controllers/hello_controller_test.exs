defmodule BookVaultWeb.HelloControllerTest do
  use BookVaultWeb.ConnCase

  test "/hello return 200", %{conn: conn} do
    conn = get(conn, "/api/hello", %{})

    assert response(conn, 200)

    assert json_response(conn, 200) == %{"message" => "Hello from BookVault!"}
  end
end
