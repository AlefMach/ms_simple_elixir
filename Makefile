include .env

build:
	docker compose build

setup:
	make build && make mix_deps && make start

mix_deps:
	docker compose run --rm -v ~/.ssh:/root/.ssh simple_ms_blocklist mix deps.get

format:
	docker compose run --rm simple_ms_blocklist mix format mix.exs "lib/**/*.{ex,exs}" "test/**/*.{ex,exs}"

credo:
	docker compose run --rm simple_ms_blocklist mix credo

ecto_setup:
	docker compose run --rm simple_ms_blocklist mix ecto.setup

ecto_migrate:
	docker compose run --rm simple_ms_blocklist mix ecto.migrate

start:
	docker compose up

remove:
	docker compose stop && docker-compose rm -f

recreate:
	make build && docker compose up --force-recreate -d

exec:
	docker exec -it admin_simple_ms_blocklist bash
