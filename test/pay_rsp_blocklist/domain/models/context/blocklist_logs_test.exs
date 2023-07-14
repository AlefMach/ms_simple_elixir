defmodule SimpleMsBlocklist.BlocklistLogsTest do
  use SimpleMsBlocklist.DataCase

  alias SimpleMsBlocklist.Context.BlocklistLogs

  describe "block_list" do
    alias SimpleMsBlocklist.Schemas.In.BlocklistLog

    import SimpleMsBlocklist.BlocklistLogsFixtures

    @invalid_attrs %{action: nil, reason: nil, responsible_area: nil}

    test "list_blocklist_logs/0 returns all blocklist_logs" do
      blocklist_log = blocklist_log_fixture()
      assert BlocklistLogs.list_blocklist_logs() == [blocklist_log]
    end

    test "get_blocklist_log!/1 returns the blocklist_log with given id" do
      blocklist_log = blocklist_log_fixture()
      assert BlocklistLogs.get_blocklist_log!(blocklist_log.id) == blocklist_log
    end

    test "create_blocklist_log/1 with valid data creates a blocklist_log" do
      valid_attrs = %{
        action: "some action",
        reason: "some reason",
        responsible_area: "some responsible_area"
      }

      assert {:ok, %BlocklistLog{} = blocklist_log} = BlocklistLogs.create_blocklist_log(valid_attrs)
      assert blocklist_log.action == "some action"
      assert blocklist_log.reason == "some reason"
      assert blocklist_log.responsible_area == "some responsible_area"
    end

    test "create_blocklist_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BlocklistLogs.create_blocklist_log(@invalid_attrs)
    end

    test "update_blocklist_log/2 with valid data updates the blocklist_log" do
      blocklist_log = blocklist_log_fixture()

      update_attrs = %{
        action: "some updated action",
        reason: "some updated reason",
        responsible_area: "some updated responsible_area"
      }

      assert {:ok, %BlocklistLog{} = blocklist_log} =
               BlocklistLogs.update_blocklist_log(blocklist_log, update_attrs)

      assert blocklist_log.action == "some updated action"
      assert blocklist_log.reason == "some updated reason"
      assert blocklist_log.responsible_area == "some updated responsible_area"
    end

    test "update_blocklist_log/2 with invalid data returns error changeset" do
      blocklist_log = blocklist_log_fixture()

      assert {:error, %Ecto.Changeset{}} =
               BlocklistLogs.update_blocklist_log(blocklist_log, @invalid_attrs)

      assert blocklist_log == BlocklistLogs.get_blocklist_log!(blocklist_log.id)
    end

    test "delete_blocklist_log/1 deletes the blocklist_log" do
      blocklist_log = blocklist_log_fixture()
      assert {:ok, %BlocklistLog{}} = BlocklistLogs.delete_blocklist_log(blocklist_log)
      assert_raise Ecto.NoResultsError, fn -> BlocklistLogs.get_blocklist_log!(blocklist_log.id) end
    end

    test "change_blocklist_log/1 returns a blocklist_log changeset" do
      blocklist_log = blocklist_log_fixture()
      assert %Ecto.Changeset{} = BlocklistLogs.change_blocklist_log(blocklist_log)
    end
  end
end
