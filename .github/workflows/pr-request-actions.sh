#!/bin/bash

set -euo pipefail

# assumes `devenv up -d` has been run

MIX_ENV=test

cd hello_team_umbrella
mix do deps.get, compile
mix ecto.drop ||:
mix ecto.setup
mix test
# cd apps/hello_team ; mix test
# cd ../../

# cd apps/hello_team_web ; mix test
