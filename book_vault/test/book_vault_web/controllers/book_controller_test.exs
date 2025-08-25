defmodule BookVaultWeb.BookControllerTest do
  alias BookVault.BooksFixtures
  use BookVaultWeb.ConnCase

  describe "POST /api/books" do
    test "POST /api/books return 200", %{conn: conn} do
      conn = post(conn, "/api/books", %{
          "book" => %{
            "author" => "some author",
            "title" => "some title",
            "description" => "some description"
          }
        })

      response = json_response(conn, 200)

      assert response["message"] == "Book created successfully!"
      assert response["book"]["title"] == "some title"
      assert response["book"]["author"] == "some author"
      assert response["book"]["description"] == "some description"
    end

    test "POST /api/books return 400 invalid data", %{conn: conn} do
      conn = post(conn, "/api/books", %{"book" => %{
        "author" => nil,
        "title" => "some title",
        "description" => "some description"
      }})

      response = json_response(conn, 400)

      assert response["errorCode"] == "validation_failed"
      assert response["errorMessage"]["author"] == ["can't be blank"]


      conn = post(conn, "/api/books", %{"book" => %{
        "author" => "some author",
        "title" => nil,
        "description" => "some description"
      }})

      response = json_response(conn, 400)

      assert response["errorCode"] == "validation_failed"
      assert response["errorMessage"]["title"] == ["can't be blank"]
    end

    test "POST /api/books return 400 duplicate data", %{conn: conn} do
      book = %{
        "author" => "some author",
        "title" => "some title",
        "description" => "some description"
      }
      conn = post(conn, "/api/books", %{"book" => book})
      conn = post(conn, "/api/books", %{"book" => book})

      response = json_response(conn, 400)

      assert response["errorCode"] == "validation_failed"
      assert response["errorMessage"]["title"] == ["has already been taken"]
    end
  end

  describe "GET /api/books" do
    test "GET /api/books return 200 empty", %{conn: conn} do
      conn = get(conn, "/api/books")

      assert json_response(conn, 200) == []
    end

    test "GET /api/books return 200 with data", %{conn: conn} do
      book = %{
        "author" => "some author",
        "title" => "some title",
        "description" => "some description"
      }
      conn = post(conn, "/api/books", %{"book" => book})

      conn = get(conn, "/api/books")

      response = json_response(conn, 200)

      assert Enum.at(response, 0)["author"] == "some author"
      assert Enum.at(response, 0)["title"] == "some title"
      assert Enum.at(response, 0)["description"] == "some description"
    end
  end

  describe "PUT /api/books/:id" do
    test "PUT /api/books/:id return 200", %{conn: conn} do
      book = %{
        "author" => "some author",
        "title" => "some title",
        "description" => "some description"
      }
      updatedBook = %{
        "author" => "updated author",
        "title" => "updated title",
        "description" => "updated description"
      }

      conn = post(conn, "/api/books", %{"book" => book})
      response = json_response(conn, 200)

      conn = put(conn, "/api/books/#{response["book"]["id"]}", %{"book" => updatedBook})

      conn = get(conn, "/api/books")

      response = json_response(conn, 200)

      assert Enum.at(response, 0)["author"] == "updated author"
      assert Enum.at(response, 0)["title"] == "updated title"
      assert Enum.at(response, 0)["description"] == "updated description"
    end

    test "PUT /api/books/:id return 404 book not found", %{conn: conn} do
      book = %{
        "author" => "updated author",
        "title" => "updated title",
        "description" => "updated description"
      }

      conn = put(conn, "/api/books/1", %{"book" => book})
      response = json_response(conn, 404)

      assert response["errorCode"] == "BOOK_NOT_FOUND"
      assert response["errorMessage"] == "Book not found"
    end

    test "PUT /api/books/:id return 400 unique key exist", %{conn: conn} do
      book = %{
        "author" => "some author",
        "title" => "some title",
        "description" => "some description"
      }
      book2 = %{
        "author" => "some author 2",
        "title" => "some title 2",
        "description" => "some description"
      }
      updatedBook = %{
        "author" => "some author",
        "title" => "some title",
        "description" => "updated description"
      }

      conn = post(conn, "/api/books", %{"book" => book})
      conn = post(conn, "/api/books", %{"book" => book2})
      response = json_response(conn, 200)

      conn = put(conn, "/api/books/#{response["book"]["id"]}", %{"book" => updatedBook})

      response = json_response(conn, 400)

      assert response["errorCode"] == "validation_failed"
      assert response["errorMessage"]["title"] == ["has already been taken"]
    end
  end

  describe "DELETE /api/books/:id" do
    test "DELETE /api/books/:id return 200", %{conn: conn} do
      book = BooksFixtures.book_fixture();
      book_id = book.id

      conn = delete(conn, "/api/books/#{book_id}")
      response = json_response(conn, 200)

      assert response["message"] == "Book #{book_id} deleted successfully!"
    end

    test "DELETE /api/books/:id return 404 book not found", %{conn: conn} do
      conn = delete(conn, "/api/books/1")
      response = json_response(conn, 404)

      assert response["errorCode"] == "BOOK_NOT_FOUND"
      assert response["errorMessage"] == "Book not found"
    end
  end
end
