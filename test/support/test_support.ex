defmodule SimpleMsBlocklistWeb.TestSupport do
  @moduledoc false

  import Plug.Conn

  @doc """
  Logs-in an user
  """
  def login(conn, id \\ 1, group \\ "admin"), do: do_login(conn, id, group)

  defp do_login(conn, id, group) do
    case AuthTools.Guardian.encode_and_sign(%{id: id}, %{groups: [group]}) do
      {:ok, token, _resource} ->
        put_req_header(conn, "authorization", "Bearer #{token}")

      _ ->
        {:error, "Couldn't login"}
    end
  end
end
