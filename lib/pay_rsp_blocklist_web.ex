defmodule SimpleMsBlocklistWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use SimpleMsBlocklistWeb, :controller
      use SimpleMsBlocklistWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  alias SimpleMsBlocklistWeb.BaseView

  import Phoenix.Controller, only: [put_view: 2, render: 3]
  import Plug.Conn

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def controller do
    quote do
      use Phoenix.Controller, namespace: SimpleMsBlocklistWeb

      import Plug.Conn
      import SimpleMsBlocklistWeb.Gettext
      import SimpleMsBlocklistWeb, only: [render_response: 2, render_response: 3]

      alias SimpleMsBlocklistWeb.Router.Helpers, as: Routes
    end
  end

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def view do
    quote do
      use Phoenix.View,
        root: "lib/simple_ms_blocklist_web/templates",
        namespace: SimpleMsBlocklistWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
    end
  end

  # credo:disable-for-next-line Credo.Check.Readability.Specs
  def channel do
    quote do
      use Phoenix.Channel
      import SimpleMsBlocklistWeb.Gettext
    end
  end

  defp view_helpers do
    quote do
      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import SimpleMsBlocklistWeb.ErrorHelpers
      import SimpleMsBlocklistWeb.Gettext
      alias SimpleMsBlocklistWeb.Router.Helpers, as: Routes
    end
  end

  @doc """
  Renders a success response with `data` property inside response body (nil if `data` is empty)
  so FallbackController can render the response correctly.
  """
  def render_response(nil, _conn), do: nil

  @spec render_response(atom, Plug.Conn.t()) :: Plug.Conn.t()
  def render_response(:empty, conn) do
    conn
    |> put_status(:ok)
    |> put_view(BaseView)
    |> render("response.json", data: :empty)
  end

  @spec render_response(map | list, Plug.Conn.t()) :: Plug.Conn.t()
  def render_response(data, conn) do
    conn
    |> put_status(:ok)
    |> put_view(BaseView)
    |> render("response.json", data: data)
  end

  @doc """
  Renders response body with status and `data`.
  """
  @spec render_response(map | list, Plug.Conn.t(), atom) :: Plug.Conn.t()
  def render_response(data, conn, status) do
    conn
    |> put_status(status)
    |> put_view(BaseView)
    |> render("response.json", data: data)
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
