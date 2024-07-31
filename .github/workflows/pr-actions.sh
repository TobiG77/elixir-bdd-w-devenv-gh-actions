#!/bin/bash

set -euo pipefail

# assumes `devenv up -d` has been run

cd hello_team_umbrella
mix do deps.get, compile
mix ecto.drop ||:
mix ecto.setup
mix test
