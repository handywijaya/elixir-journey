defmodule BookVaultWeb.ThermostatLiveTest do
  use BookVaultWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  test "render thermostat live page", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/thermostat")

    assert html =~ "Thermostat"
    assert html =~ "20°C"
  end
end
