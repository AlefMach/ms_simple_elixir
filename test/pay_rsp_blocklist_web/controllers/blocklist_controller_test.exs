defmodule SimpleMsBlocklistWeb.BlocklistControllerTest do
  use SimpleMsBlocklistWeb.ConnCase, async: false

  import SimpleMsBlocklist.Factory
  import SimpleMsBlocklistWeb.TestSupport

  setup %{conn: conn} do
    final_conn =
      conn
      |> login()

    %{conn: final_conn}
  end

  describe "handle/2" do
    test "testing request with the correct cnpj", %{conn: conn} do
      blocked_partner = insert(:blocked_partners)

      response = get(conn, "/blocklist/#{blocked_partner.cnpj}")

      assert json_response(response, 200)
      assert response.resp_body == "{\"blocked\":true}"
    end

    test "testing request with the correct cnpj and not blocked", %{conn: conn} do
      blocked_partner = insert(:blocked_partners, reason: "fraude_cpf")

      response = get(conn, "/blocklist/#{blocked_partner.cnpj}")

      assert json_response(response, 200)
      assert response.resp_body == "{\"blocked\":false}"
    end

    test "testing request with the correct cnpj, but the data isn't saved in bd", %{conn: conn} do
      response = get(conn, "/blocklist/25.643.7270001-18")

      assert json_response(response, 200)
      assert response.resp_body == "{\"blocked\":false}"
    end

    test "testing request with the incorrect cnpj", %{conn: conn} do
      response = get(conn, "/blocklist/12352652152458")

      assert json_response(response, 400)
      assert response.resp_body == "{\"error\":{\"details\":\"Invalid CNPJ\"}}"
    end
  end
end
