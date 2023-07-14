# Análise estática de código

## Formatação

Todo código `elixir` deve ser formatado usando o formatador nativo, que pode ser invocado pelo comando `mix format`. No CI do GitHub, a formatação é invocada [aqui](../.github/workflows/elixir.yml#L78), utilizando a flag `--check-formatted` para que a action falhe caso o código não esteja formatado.

## Consistência e o Credo

A consistência do código é verificada utilizando o [Credo](https://github.com/rrrene/credo), uma ferramenta que tem como objetivo identificar oportunidades de refatoração, aconselhar e ensinar boas práticas de codificação em `elixir`. No CI do Github, o Credo é invocado [aqui](../.github/workflows/elixir.yml#L99), utilizando a flag `--strict` que identifica a necessidade de verificar todos tipos possíveis de problemas, independente da severidade.