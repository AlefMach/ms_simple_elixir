defmodule SimpleMsBlocklistWeb.ErrorViewTest do
  use SimpleMsBlocklistWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render(SimpleMsBlocklistWeb.ErrorView, "404.json", []) == %{
             error: %{details: "Not Found"}
           }
  end

  test "renders 500.json" do
    assert render(SimpleMsBlocklistWeb.ErrorView, "500.json", []) ==
             %{error: %{details: "Internal Server Error"}}
  end
end
