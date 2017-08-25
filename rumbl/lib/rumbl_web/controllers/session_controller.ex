defmodule RumblWeb.SessionController do
  use RumblWeb, :controller
  alias Rumbl.Repo

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{ "username" => user, "password" => password }}) do
    case RumblWeb.Auth.login_by_username_and_pass(conn, user, password, repo: Repo) do
      { :ok, conn } ->
        conn
        |> put_flash(:info, "Welcome")
        |> redirect(to: page_path(conn, :index))
      { :error, _reason, conn } ->
        conn
        |> put_flash(:info, "Failed")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> RumblWeb.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end
end
