defmodule BookVaultWeb.HeaderComponentTest do
  use BookVaultWeb.ConnCase, async: true
  import Phoenix.LiveViewTest
  alias BookVaultWeb.HeaderComponent

  test "render header component", %{conn: _conn} do
    html = render_component(&HeaderComponent.header/1, %{page: "thermostat"})

    assert html =~ "BookVault"
    assert html =~ "Home"
    assert html =~ "Thermostat"
    assert html =~ "Library"
  end
end
