defmodule BookVaultWeb.FooterComponent do
  use Phoenix.Component

  def footer(assigns) do
    ~H"""
    <footer class="w-full h-10 text-slate-600 pt-2 pb-2 text-center bg-gray-50">
      &copy; {Date.utc_today().year}
      <a href="https://github.com/handywijaya" class="hover:underline">
        Handy Wijaya
      </a>
    </footer>
    """
  end

  def footerAbs(assigns) do
    ~H"""
    <footer class="w-full h-10 absolute bottom-0 text-slate-600 pt-2 pb-2 text-center bg-gray-50">
      &copy; {Date.utc_today().year}
      <a href="https://github.com/handywijaya" class="hover:underline">
        Handy Wijaya
      </a>
    </footer>
    """
  end
end
