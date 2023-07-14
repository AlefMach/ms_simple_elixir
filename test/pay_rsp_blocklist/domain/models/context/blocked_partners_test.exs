defmodule SimpleMsBlocklist.BlockedPartnersTest do
  use SimpleMsBlocklist.DataCase

  alias SimpleMsBlocklist.Context.BlockedPartners

  describe "blocked_partner" do
    alias SimpleMsBlocklist.Schemas.In.BlockedPartner

    import SimpleMsBlocklist.BlocklistsFixtures

    @invalid_attrs %{
      cnpj: nil,
      deleted_at: nil,
      expiration_date: nil,
      note: nil,
      partner_id: nil,
      reason: nil,
      responsible_area: nil
    }

    test "list_all/0 returns all blocked_partner" do
      blocked_partner = blocklist_fixture()
      assert BlockedPartners.list_all() == [blocked_partner]
    end

    test "get!/1 returns the blocked_partner with given id" do
      blocked_partner = blocklist_fixture()
      assert BlockedPartners.get!(blocked_partner.id) == blocked_partner
    end

    test "create/1 with valid data creates a blocked_partner" do
      cnpj = generate_cnpj()
      reason = select_a_shuffle_reason()

      valid_attrs = %{
        cnpj: cnpj,
        deleted_at: nil,
        expiration_date: ~U[2023-01-09 19:07:00Z],
        note: "some note",
        partner_id: 42,
        reason: reason
      }

      assert {:ok, %BlockedPartner{} = blocked_partner} = BlockedPartners.create(valid_attrs)

      assert blocked_partner.cnpj == cnpj
      assert blocked_partner.deleted_at == nil
      assert blocked_partner.expiration_date == ~U[2023-01-09 19:07:00Z]
      assert blocked_partner.note == "some note"
      assert blocked_partner.partner_id == 42
      assert Atom.to_string(blocked_partner.reason) == reason
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BlockedPartners.create(@invalid_attrs)
    end

    test "update/2 with valid data updates the blocked_partner" do
      blocked_partner = blocklist_fixture()

      cnpj = generate_cnpj()
      reason = select_a_shuffle_reason()

      update_attrs = %{
        cnpj: cnpj,
        deleted_at: nil,
        expiration_date: ~U[2023-01-09 19:07:00Z],
        note: "some updated note",
        partner_id: 42,
        reason: reason
      }

      assert {:ok, %BlockedPartner{} = blocked_partner} =
               BlockedPartners.update(blocked_partner, update_attrs)

      assert blocked_partner.cnpj == cnpj
      assert blocked_partner.deleted_at == nil
      assert blocked_partner.expiration_date == ~U[2023-01-09 19:07:00Z]
      assert blocked_partner.note == "some updated note"
      assert blocked_partner.partner_id == 42
      assert Atom.to_string(blocked_partner.reason) == reason
    end

    test "update/2 with invalid data returns error changeset" do
      blocked_partner = blocklist_fixture()

      assert {:error, %Ecto.Changeset{}} = BlockedPartners.update(blocked_partner, @invalid_attrs)

      assert blocked_partner == BlockedPartners.get!(blocked_partner.id)
    end

    test "delete/1 deletes the blocked_partner" do
      blocked_partner = blocklist_fixture()

      assert {:ok, %BlockedPartner{}} = BlockedPartners.delete(blocked_partner)
    end

    test "change/1 returns a blocked_partner changeset" do
      blocked_partner = blocklist_fixture()
      assert %Ecto.Changeset{} = BlockedPartners.change(blocked_partner)
    end
  end
end
