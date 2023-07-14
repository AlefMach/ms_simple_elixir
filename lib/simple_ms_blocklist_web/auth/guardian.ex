defmodule SimpleMsBlocklistWeb.Auth.Guardian do
  @moduledoc """
  Define como os recursos são recuperados
  e enviados via JWT
  """

  use Guardian, otp_app: :simple_ms_blocklist

  @spec subject_for_token(struct, map) :: {:ok, String.t()} | {:error, String.t()}
  def subject_for_token(_struct, _claims) do
    # TODO
  end

  @spec resource_from_claims(map) :: {:ok, struct} | {:error, String.t()}
  def resource_from_claims(_claims) do
    # TODO
  end
end
