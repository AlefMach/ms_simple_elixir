defmodule SimpleMsBlocklist.UseCases.HealthCheck do
  @moduledoc """
  HealthCheck das dependencias da aplicação
  """
  require Logger

  alias SimpleMsBlocklist.Repo

  @spec check :: {:ok, atom()} | {:error, atom()}
  def check do
    [
      database_check()
    ]
    |> Enum.all?(&match?({:ok, _}, &1))
    |> handle_result()
  end

  defp database_check, do: Repo.query("SELECT 1")

  defp handle_result(true), do: {:ok, :up}
  defp handle_result(false), do: {:error, :down}
end
