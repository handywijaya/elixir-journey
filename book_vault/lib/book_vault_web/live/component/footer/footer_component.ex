defmodule BookVaultWeb.FooterComponent do
  use Phoenix.Component

  def footer(assigns) do
    ~H"""
    <footer class="absolute bottom-0 text-slate-600 pb-2">
      &copy; {Date.utc_today().year}
      <a href="https://github.com/handywijaya" class="hover:underline">
        Handy Wijaya
      </a>
    </footer>
    """
  end
end
