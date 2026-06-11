defmodule SanchaWeb.Dash do
  use SanchaWeb, :live_view

  @impl true

  def mount(_params, session, socket) do
    user_id = session["user_id"]
    {:ok, user} = Sancha.Accounts.get_user(user_id)

    socket =
      socket
      |> assign(user_data: user)

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="avatar">
      <div class="w-10 rounded-full">
        <img src={@user_data.avatar} />
      </div>
    </div>
    """
  end
end
