defmodule Sancha.Uuid.Repo do
  import Ecto.Query
  alias Sancha.Repo

  def add_uuid(batch_size \\ 1000) do
    batch =
      Enum.map(1..batch_size, fn _ ->
        %{
          uuid: Ecto.UUID.generate(version: 7, precision: :monotonic),
          claimed: false,
          claimed_by: nil
        }
      end)

    Sancha.Repo.insert_all(Sancha.Uuid, batch)
    Sancha.Uuid.Counter.increment(1000)
  end

  def claim_uuid(uuid \\ nil) do
    subquery =
      from u in Sancha.Uuid,
        where: u.claimed == false,
        order_by: [asc: u.uuid],
        lock: "FOR UPDATE SKIP LOCKED",
        limit: 1,
        select: u.uuid

    query =
      from u in Sancha.Uuid,
        join: sq in subquery(subquery),
        on: u.uuid == sq.uuid,
        select: u

    case Repo.update_all(query, set: [claimed: true, claimed_by: uuid]) do
      {1, [claimed_record]} ->
        Sancha.Uuid.Counter.decrement()
        {:ok, claimed_record.uuid}

      {0, []} ->
        {:error, :queue_empty}
    end
  end
end
