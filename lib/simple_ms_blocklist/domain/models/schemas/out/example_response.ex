defmodule SimpleMsBlocklist.Example.Schemas.Out.ExampleResponse do
  @moduledoc false

  @derive Jason.Encoder

  @fields quote(
            do: [
              id: integer()
            ]
          )

  defstruct Keyword.keys(@fields)

  @type t() :: %__MODULE__{unquote_splicing(@fields)}
end
