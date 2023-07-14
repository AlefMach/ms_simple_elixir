defmodule SimpleMsBlocklist.MixProject do
  use Mix.Project

  @production_excluded_paths ~w(credo)s

  def project do
    [
      app: :simple_ms_blocklist,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [ci: :test],
      aliases: aliases(),
      releases: releases(),
      deps: deps(),
      name: "Template de Serviço",
      source_url: "https://github.com/AlefMach/ms_simple_elixir",
      docs: [
        main: "Template",
        formatters: ["html"],
        extras: [
          "README.md",
          "guides/local/asdf.md",
          "guides/local/docker.md",
          "guides/local/nix.md",
          ".env-sample"
        ],
        groups_for_extras: [
          "Ambiente de desenvolvimento": ~r/guides\/local\/.*/
        ]
      ],
      test_coverage: [
        tool: ExCoveralls
      ]
    ]
  end

  def application do
    [
      mod: {SimpleMsBlocklist.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(:prod), do: project_paths_excluding_credo()
  defp elixirc_paths(_), do: ["lib"]

  defp project_paths_excluding_credo do
    root_lib_path = "lib"

    root_lib_path
    |> File.ls!()
    |> Enum.reject(&(&1 in @production_excluded_paths))
    |> Enum.map(&Path.join(root_lib_path, &1))
  end

  defp deps do
    [
      # start deps
      {:brcpfcnpj, "~> 1.0.0"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:cowlib, "~> 2.11.0", override: true},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ecto_sql, "~> 3.10"},
      {:ecto_soft_delete, "~> 2.0"},
      {:excoveralls, "~> 0.14 and >= 0.14.4", only: [:test]},
      {:ex_doc, "~> 0.27.3", only: [:dev], runtime: false},
      {:ex_machina, "~> 2.7.0"},
      {:gen_smtp, "~> 1.0"},
      {:gettext, "~> 0.18"},
      {:google_protos, "~> 0.1"},
      {:guardian, "~> 2.0"},
      {:gun, github: "ninenines/gun", tag: "2.0.0-rc.2", override: true},
      {:grpc, github: "elixir-grpc/grpc"},
      {:hackney, "~> 1.18"},
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"},
      {:logger_json, "~> 5.0", only: :prod},
      {:mox, "~> 1.0"},
      {:open_api_spex, "~> 3.11"},
      {:phoenix, "~> 1.6.6"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:plug_cowboy, "~> 2.5"},
      {:postgrex, ">= 0.0.0"},
      {:prom_ex, "~> 1.6"},
      {:protobuf, "~> 0.8.0"},
      {:sentry, "~> 8.0"},
      {:spandex, "~> 3.1"},
      {:spandex_datadog, "~> 1.2"},
      {:spandex_phoenix, "~> 1.0"},
      {:spandex_ecto, "~> 0.7.0"},
      {:swoosh, "~> 1.6"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"}
      # end deps
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "test.reset": ["ecto.drop", "test"],
      ci: ["format --check-formatted", "credo --strict", "test"]
    ]
  end

  defp releases do
    [
      simple_ms_blocklist: [
        applications: [
          simple_ms_blocklist: :permanent
        ]
      ]
    ]
  end
end
