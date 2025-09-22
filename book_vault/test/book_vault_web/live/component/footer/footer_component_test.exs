defmodule BookVaultWeb.FooterComponentTest do
  use BookVaultWeb.ConnCase, async: true
  import Phoenix.LiveViewTest
  alias BookVaultWeb.FooterComponent

  test "render footer component", %{conn: _conn} do
    html = render_component(&FooterComponent.footer/1, %{})

    assert html =~ "Handy Wijaya"
    refute html =~ "absolute bottom-0"
  end

  test "render footerAbs component", %{conn: _conn} do
    html = render_component(&FooterComponent.footerAbs/1, %{})

    assert html =~ "Handy Wijaya"
    assert html =~ "absolute bottom-0"
  end
end
