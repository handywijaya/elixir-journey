defmodule BookVaultWeb.LibraryLiveTest do
  use BookVaultWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  test "render library live page", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/library")

    assert html =~ "Library"
    assert html =~ "Add Book"
    assert html =~ "Title"
    assert html =~ "Author"
    assert html =~ "Description"
    assert html =~ "Add Book"
  end
end
