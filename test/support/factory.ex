defmodule SimpleMsBlocklist.Factory do
  @moduledoc """
  Re-exporta as factories da aplicação
  """

  use ExMachina.Ecto, repo: SimpleMsBlocklist.Repo

  use BlockedPartnersFactory
end
