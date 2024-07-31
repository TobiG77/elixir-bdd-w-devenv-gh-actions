defmodule HelloTeamWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use HelloTeamWeb, :controller` and
  `use HelloTeamWeb, :live_view`.
  """
  use HelloTeamWeb, :html

  embed_templates "layouts/*"
end
