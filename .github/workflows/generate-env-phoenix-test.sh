#!/bin/bash

[ -e .env-phoenix-test ] || {
  cd hello_team_umbrella
  mix local.hex --force
  mix local.rebar --force
  MIX_PHX_GEN_SECRET=$(mix phx.gen.secret)
  echo test
  export MIX_PHX_GEN_SECRET
  envsubst < ../env-phoenix-example > ../.env-phoenix-test
}
