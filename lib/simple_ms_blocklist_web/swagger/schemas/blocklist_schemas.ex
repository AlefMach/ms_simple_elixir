defmodule SimpleMsBlocklistWeb.Swagger.Schema.BlocklistSchemas do
  @moduledoc false

  require OpenApiSpex
  alias OpenApiSpex.Schema

  defmodule BlocklistResponse do
    @moduledoc false

    OpenApiSpex.schema(%{
      description: "Returns a boolean value",
      type: :object,
      properties: %{
        json: %Schema{type: :json, description: "Example return boolean"}
      },
      example: %{is_blocked: false}
    })
  end
end
