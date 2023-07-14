defmodule SimpleMsBlocklist.Example.FeatureFlag do
  @moduledoc """
  Contexto para expor as funções de Feature Flag da aplicação. Atualmente estamos usando
  a lib [FeatureFlag](https://github.com/solfacil/feature-flag) como abstração do SDK da
  Launch Darkly.

  Ela expõe a função `check/3` para recuperar o valor da flag configurada na ferramenta.

  ### Uso

      user = %FeatureFlag.User{key: "123", name: "John", email: "john@example.com"}
      FeatureFlag.check("allow-login", user)
      true


  Acessar o [repositório](https://github.com/solfacil/feature-flag) para mais detalhes sobre
  a documentação e funcionamento da lib.
  """
end
