defmodule SimpleMsBlocklist.EmbeddedSchema do
  @moduledoc """
  Fornece uma macro para abstrair o uso do Ecto.Schema e padronizar alguns defaults
  do módulo para o uso de embedded schemas. Expõe a função `maybe_apply_changes` para
  retornar o dado contido em `data` do changeset.

  ### Uso

      def YourApp.Schema.Customer do
        use SimpleMsBlocklist.EmbeddedSchema

        ...

        @spec changeset(map) :: {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
        def changeset(attrs) do
          %__MODULE{}
          |> cast(attrs, @fields)
          |> maybe_apply_changes()
        end
      end

  """

  @callback changeset(map()) :: {:ok, map()} | {:error, Ecto.Changeset.t()}

  @doc false
  @spec __using__(any) :: any
  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      @behaviour SimpleMsBlocklist.EmbeddedSchema

      @primary_key false

      @spec maybe_apply_changes(Ecto.Changeset.t()) :: {:ok, map()} | {:error, Ecto.Changeset.t()}
      def maybe_apply_changes(%Ecto.Changeset{} = changeset) do
        case changeset do
          %Ecto.Changeset{valid?: true} = changeset -> {:ok, apply_changes(changeset)}
          changeset -> {:error, changeset}
        end
      end
    end
  end
end
