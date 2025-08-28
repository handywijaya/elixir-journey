defmodule BookVaultWeb.ThermostatLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, temperature: 20)}
  end

  def render(assigns) do
    ~H"""
      Current temperature: {@temperature}°C
      <button phx-click="dec_temperature">-</button>
      <button phx-click="inc_temperature">+</button>
    """
  end

  def handle_event("inc_temperature", %{"value" => ""}, socket) do
    {:noreply, update(socket, :temperature, fn temp -> temp + 1 end)}
  end

  def handle_event("dec_temperature", %{"value" => ""}, socket) do
    {:noreply, update(socket, :temperature, fn temp -> temp - 1 end)}
  end
end
