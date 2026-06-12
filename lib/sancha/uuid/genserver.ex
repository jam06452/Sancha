defmodule Sancha.Uuid.Counter do
  use GenServer
  import Ecto.Query

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def decrement() do
    GenServer.cast(__MODULE__, :decrement)
  end

  def increment(amount) do
    GenServer.cast(__MODULE__, {:increment, amount})
  end

  def get_amount() do
    GenServer.call(__MODULE__, :get_amount)
  end

  @impl true
  def init(_) do
    initial_amount =
      Sancha.Repo.aggregate(
        from(u in Sancha.Uuid, where: u.claimed == false),
        :count,
        :uuid
      )

    final_amount =
      if initial_amount <= 250 do
        Sancha.Uuid.Repo.add_uuid()

        Sancha.Repo.aggregate(
          from(u in Sancha.Uuid, where: u.claimed == false),
          :count,
          :uuid
        )
      else
        initial_amount
      end

    {:ok, final_amount}
  end

  @impl true
  def handle_cast(:decrement, count) do
    new_count = count - 1

    if count <= 250 do
      Sancha.Uuid.Repo.add_uuid()
    end

    {:noreply, new_count}
  end

  @impl true
  def handle_cast({:increment, amount}, count) do
    {:noreply, count + amount}
  end

  @impl true
  def handle_call(:get_amount, _from, count) do
    {:reply, count, count}
  end
end
