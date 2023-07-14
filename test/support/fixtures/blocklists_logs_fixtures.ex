defmodule SimpleMsBlocklist.BlocklistLogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimpleMsBlocklist.Logs` context.
  """

  @doc """
  Generate a blocklist_log.
  """
  def blocklist_log_fixture(attrs \\ %{}) do
    {:ok, blocklist_log} =
      attrs
      |> Enum.into(%{
        action: "some action",
        reason: "some reason",
        responsible_area: "some responsible_area"
      })
      |> SimpleMsBlocklist.Context.BlocklistLogs.create_blocklist_log()

    blocklist_log
  end
end
