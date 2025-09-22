defmodule BookVaultWeb.BackgroundComponent do
  use Phoenix.Component

  def background(assigns) do
    ~H"""
    <div class="bg-gray-100 absolute inset-0 min-h-screen z-[-1]">
    </div>
    """
  end
end
