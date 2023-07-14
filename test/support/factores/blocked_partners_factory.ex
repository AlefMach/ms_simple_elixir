defmodule BlockedPartnersFactory do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      def blocked_partners_factory do
        financiamento = %SimpleMsBlocklist.Schemas.In.BlockedPartner{
          cnpj: Brcpfcnpj.cnpj_generate(),
          reason: "fraude",
          partner_id: 1,
          note: "some note",
          expiration_date: nil,
          deleted_at: nil
        }
      end
    end
  end
end
