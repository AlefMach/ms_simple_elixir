defmodule SimpleMsBlocklistWeb.BlocklistController do
  use OpenApiSpex.ControllerSpecs
  use SimpleMsBlocklistWeb, :controller

  require Logger

  alias SimpleMsBlocklist.Services.Blocklist, as: BlocklistService
  alias SimpleMsBlocklistWeb.Swagger.Schema.BlocklistSchemas
  alias SimpleMsBlocklistWeb.Swagger.Response

  action_fallback(SimpleMsBlocklistWeb.Fallback)

  @doc """
  Controller responsible for handling requests for cnpj status
  """
  operation(:handle,
    parameters: [
      cnpj: [
        in: :path,
        type: :string,
        description: "CNPJ",
        example: "36554374000104",
        required: true
      ]
    ],
    responses:
      [
        ok: {"Successful response", "application/json", BlocklistSchemas.BlocklistResponse}
      ] ++ Response.errors([:unauthorized])
  )

  def handle(conn, %{"cnpj" => cnpj} = _params) do
    with {:ok, cnpj} <- BlocklistService.parse_cnpj(cnpj) do
      handle_result(BlocklistService.is_blocked?(cnpj), conn)
    end
  end

  defp handle_result({:ok, result}, conn), do: json(conn, %{blocked: result})
  defp handle_result(result, _), do: result
end
