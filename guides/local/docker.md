# Docker

### Requerimentos mínimos

| requirement                                                   | release  |
| ------------------------------------------------------------- | -------- |
| [docker](https://docs.docker.com/get-docker/)                 | 20.10.8+ |
| [compose](https://docs.docker.com/compose/install/)           | 2.4.0+   |
---

### Processo inicial

Antes de iniciar o processo de build dos containers no Docker, é necessário forçar a versão do
`DOCKER_BUILDKIT` e `COMPOSE_DOCKER_CLI_BUILD` para `1`, de forma que não haja erros neste
processo. Para facilitar essa configuração, defina essas variáveis na inicialização do seu shell,
ex: `~/.bash_profile`, `~/.zshrc`, `~/fish/config.fish` etc:

```sh
DOCKER_BUILDKIT=1
COMPOSE_DOCKER_CLI_BUILD=1

# fish
set -x DOCKER_BUILDKIT 1
set -x COMPOSE_DOCKER_CLI_BUILD 1
```

Execute o build dos containers e obtenha as dependencias do `mix`. Será necessário passar a identificação
do SSH Agent do seu sistema (`default` para usar o seu SSH Agent padrão).

    make build

Após o comando de build, você pode instalar as dependências do app.

    make mix_deps

Depois, basta rodar o setup do banco de dados.

    make ecto_setup

### Sempre que for rodar o projeto

    docker compose up

    make start

### Para atualizar ou instalar novas dependências

    make build
    ou
    make recreate

A diferença entre os comandos é que o `make recreate` builda a nova imagem e já recria os containers, enquanto o `make build` só efetua o build da imagem, necessitando que os containers sejam criados por outro comando (`make start`)

### Para executar comandos dentro do container

    make exec

### Para executar migrações

    docker compose run --rm simple_ms_blocklist mix ecto.migrate

### Para reverter migrações

    docker compose run --rm simple_ms_blocklist mix ecto.rollback

### Para recriar o banco de dados

    docker compose run --rm simple_ms_blocklist mix ecto.reset

### Portas expostas no sistema do host

| container        | port |
| ---------------- | ---- |
| simple_ms_blocklist | 4000 |
| db               | 5432 |

---

## Rodando os testes

Para rodar os testes localmente execute o comando:

    docker compose run --rm simple_ms_blocklist mix test

E para rodar todos os testes (`format`, `credo` e `test`) use:

    docker compose run --rm simple_ms_blocklist mix ci

É recomendável rodar os testes unitários sem efetuar a recriação do DB, pois o tempo de execução será
sempre menor. Porém, se o banco de testes ficar em um estado em que os dados presentes influenciem na
execução dos testes com sucesso, é recomendado recriá-lo.
Para recriar o banco de testes, rodar as seeds e os testes unitários
(`ecto.drop`, `ecto.create`, `ecto.migrate`, `seeds` e `test`) execute:

    docker compose run --rm simple_ms_blocklist mix test.reset
