defmodule SimpleMsBlocklist.Tracer do
  @moduledoc """
  Efetua o tracking da nossa aplicação utilizando a lib [Spandex](https://github.com/spandex-project/spandex)
  para enviar ao [DataDog](https://datadoghq.com)
  """
  use Spandex.Tracer, otp_app: :simple_ms_blocklist
end
