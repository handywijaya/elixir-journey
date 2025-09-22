defmodule BookVaultWeb.HeaderComponent do
  use Phoenix.Component

  def header(assigns) do
    ~H"""
    <header class="w-full h-[64px] bg-indigo-600 shadow mb-8">
      <div class="w-[80%] h-full mx-auto px-4 py-4 relative">
        <div class="absolute left-0 items-center space-x-2">
          <span class="text-white text-xl font-bold tracking-wide">BookVault</span>
        </div>
        <nav class="absolute right-0">
          <.link
            navigate="/"
            class={[
              "font-medium px-3 py-2 rounded transition",
              @page == "/" && "bg-white text-indigo-700 font-bold shadow",
              @page != "/" && "text-indigo-100 hover:text-white"
            ]}
          >Home</.link>
          <.link
            navigate="/thermostat"
            class={[
              "font-medium px-3 py-2 rounded transition",
              @page == "thermostat" && "bg-white text-indigo-700 font-bold shadow",
              @page != "thermostat" && "text-indigo-100 hover:text-white"
            ]}
          >Thermostat</.link>
          <.link
            navigate="/library"
            class={[
              "font-medium px-3 py-2 rounded transition",
              @page == "library" && "bg-white text-indigo-700 font-bold shadow",
              @page != "library" && "text-indigo-100 hover:text-white"
            ]}
          >Library</.link>
        </nav>
      </div>
    </header>
    """
  end
end
