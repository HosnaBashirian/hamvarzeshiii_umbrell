defmodule HamVarzeshi.Chats do
  @moduledoc """
  The Chats context.
  """

  import Ecto.Query, warn: false
  alias HamVarzeshi.Repo

  alias HamVarzeshi.Chats.Message


  def create_message(user, gym, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:messages, gym_id: gym.id)
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  def list_messages() do
    query =
      from msg in Message,
        join: user in assoc(msg, :user),
        order_by: [desc: msg.inserted_at]

    Repo.all(
      from [msg, user] in query,
        select: %{body: msg.body, user: %{username: user.username}}
    )
  end

end
