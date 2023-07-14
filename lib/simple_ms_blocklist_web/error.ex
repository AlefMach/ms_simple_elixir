defmodule SimpleMsBlocklistWeb.Error do
  @moduledoc """
  Error handler to requests
  """

  import SimpleMsBlocklistWeb.Gettext

  require Logger

  alias __MODULE__

  @type t :: %Error{
          code: :atom,
          message: :string,
          status_code: :integer
        }

  defstruct [:code, :message, :status_code]

  @spec normalize(tuple) :: Error.t() | list(Error.t())
  def normalize({:error, reason}) do
    handle(reason)
  end

  def normalize({:error, _operation, reason, _changes}) do
    handle(reason)
  end

  def normalize(other) do
    handle(other)
  end

  defp handle(errors) when is_list(errors) do
    Enum.map(errors, &handle/1)
  end

  defp handle(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(fn {err, _opts} -> err end)
    |> Enum.map(fn {k, v} ->
      %Error{
        code: :validation,
        message: String.capitalize("#{k} #{v}"),
        status_code: 422
      }
    end)
  end

  defp handle(map) when is_map(map) do
    Enum.map(map, fn {_key, value} -> handle(value) end)
  end

  defp handle(code) when is_atom(code) do
    {status, message} = metadata(code)

    %Error{
      code: code,
      message: message,
      status_code: status
    }
  end

  defp handle(string) when is_binary(string) do
    %Error{
      code: :unknown_resource,
      message: string,
      status_code: 400
    }
  end

  defp handle(other) do
    Logger.error("Unhandled error term:\n#{inspect(other)}")
    handle(:unknown)
  end

  defp metadata(:unknown_resource), do: {400, dgettext("errors", "Unknown Resource")}
  defp metadata(:invalid_argument), do: {400, dgettext("errors", "Invalid arguments passed")}
  defp metadata(:unauthenticated), do: {401, dgettext("errors", "Not authenticated")}

  defp metadata(:password_hash_missing),
    do: {401, dgettext("errors", "Reset your password to login")}

  defp metadata(:invalid_credentials), do: {401, dgettext("errors", "Email or password invalid")}

  defp metadata(:unauthorized),
    do: {403, dgettext("errors", "You don't have permission to do this")}

  defp metadata(:not_found), do: {404, dgettext("errors", "Resource not found")}
  defp metadata(:user_not_found), do: {404, dgettext("errors", "User not found")}
  defp metadata(:unknown), do: {500, dgettext("errors", "Something went wrong")}

  defp metadata(code) do
    Logger.warn("Unhandled error code: #{inspect(code)}")
    {422, to_string(code)}
  end
end
