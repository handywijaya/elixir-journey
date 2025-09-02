defmodule BookVaultWeb.ThermostatLive do
  use Phoenix.LiveView
  import BookVaultWeb.FooterComponent

  def mount(_params, _session, socket) do
    {:ok, assign(socket, temperature: 20)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center justify-center min-h-screen bg-gray-100">
      <div class="bg-white rounded-lg shadow-lg p-8 flex flex-col items-center">
        <h1 class="text-3xl font-bold mb-4">Thermostat</h1>
        <div class="text-6xl font-mono mb-6">
          <span>{@temperature}°C</span>
        </div>
        <div class="flex space-x-6">
          <button
            phx-click="dec_temperature"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-3 px-6 rounded-full text-2xl transition"
            aria-label="Decrease temperature"
          >-</button>
          <button
            phx-click="inc_temperature"
            class="bg-red-500 hover:bg-red-700 text-white font-bold py-3 px-6 rounded-full text-2xl transition"
            aria-label="Increase temperature"
          >+</button>
        </div>
      </div>
      <.footer />
    </div>
    """
  end

  def handle_event("inc_temperature", %{"value" => ""}, socket) do
    {:noreply, update(socket, :temperature, fn temp -> temp + 1 end)}
  end

  def handle_event("dec_temperature", %{"value" => ""}, socket) do
    {:noreply, update(socket, :temperature, fn temp -> temp - 1 end)}
  end
end
