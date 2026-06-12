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
    <header class="sticky top-0 z-50 w-full border-b border-base-200 bg-base-100/80 backdrop-blur-md">
      <div class="mx-auto flex h-14 max-w-screen-xl items-center justify-between px-6">
        <%!-- Wordmark --%>
        <a href="/" class="flex items-center gap-2.5 group">
          <span class="inline-block h-5 w-0.5 rounded-full bg-indigo-500"></span>
          <span class="text-base font-semibold tracking-tight text-base-content transition-opacity group-hover:opacity-70">
            Sancha
          </span>
        </a>

        <%!-- Desktop nav --%>
        <nav class="hidden md:flex items-center gap-1"></nav>

        <%!-- Right side: avatar + user menu --%>
        <div class="flex items-center gap-3">
          <div class="dropdown dropdown-end">
            <div tabindex="0" role="button" class="flex items-center gap-2.5 cursor-pointer group">
              <div class="avatar">
                <div class="w-8 rounded-full ring-1 ring-base-300 group-hover:ring-indigo-500 transition-all">
                  <img src={@user_data.avatar} alt="Your avatar" />
                </div>
              </div>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-3.5 w-3.5 text-base-content/40 group-hover:text-base-content/70 transition-colors"
                viewBox="0 0 20 20"
                fill="currentColor"
              >
                <path
                  fill-rule="evenodd"
                  d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z"
                  clip-rule="evenodd"
                />
              </svg>
            </div>

            <ul
              tabindex="-1"
              class="dropdown-content menu menu-sm bg-base-100 border border-base-200 rounded-xl mt-3 w-48 p-1.5 shadow-lg z-50"
            >
              <li class="menu-title px-2 py-1.5">
                <span class="text-xs font-medium text-base-content/40 uppercase tracking-widest">
                  Account
                </span>
              </li>
              <li class="mt-1 pt-1 border-t border-base-200">
                <.link
                  href={~p"/logout"}
                  class="rounded-lg text-sm text-error/80 hover:text-error hover:bg-error/10"
                >
                  Sign out
                </.link>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </header>
    """
  end
end
