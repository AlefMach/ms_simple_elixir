# asdf

### Requerimentos mínimos

| requirement                                               | release |
| --------------------------------------------------------- | ------- |
| [asdf](https://asdf-vm.com/)                              | 0.9.0+  |
| [asdf-postgres](https://github.com/smashedtoatoms/asdf-postgres#dependencies) | - |
| [asdf-elixir](https://github.com/asdf-vm/asdf-elixir#install)                 | - |
| [asdf-erlang](https://github.com/asdf-vm/asdf-erlang#install)                 | - |


---

### Processo inicial

Dentro do diretório do projeto, execute:

```sh
asdf install
```

Serão baixadas as versões exatas da `Erlang/OTP` e `Elixir` usadas no projeto.

Como a opção padrão para executar o projeto é com `Docker`, é necessário criar um arquivo `local.secret.exs` na pasta `config` com o seguinte conteúdo:
```elixir
import Config

config :simple_ms_blocklist, SimpleMsBlocklist.Repo,
  hostname: "localhost"
```

### Sempre que for rodar o projeto

Suba o servidor do `Phoenix` normalmente:
```sh
iex -S mix phx.server
```

O servidor estará disponível em `localhost`, na porta `4000`.

### Para executar migrações

```sh
mix ecto.migrate
```

### Para reverter migrações

```sh
mix ecto.rollback
```

### Para recriar o banco de dados

```sh
mix ecto.reset
```

---

## Rodando os testes

Para rodar os testes localmente execute o comando:

```sh
mix test
```

E para rodar todos os testes (`format`, `credo` e `test`) use:

```sh
mix ci
```

É recomendável rodar os testes unitários sem efetuar a recriação do DB, pois o tempo de execução será
sempre menor. Porém, se o banco de testes ficar em um estado em que os dados presentes influenciem na
execução dos testes com sucesso, é recomendado recriá-lo.
Para recriar o banco de testes, rodar as seeds e os testes unitários
(`ecto.drop`, `ecto.create`, `ecto.migrate`, `seeds` e `test`) execute:

```sh
mix test.reset
```
