defmodule BookVaultWeb.BackgroundComponentTest do
  use BookVaultWeb.ConnCase, async: true
  import Phoenix.LiveViewTest
  alias BookVaultWeb.BackgroundComponent

  test "render background component", %{conn: _conn} do
    html = render_component(&BackgroundComponent.background/1, %{})

    assert html =~ "bg-gray-100 absolute inset-0 min-h-screen z-[-1]"
  end
end
