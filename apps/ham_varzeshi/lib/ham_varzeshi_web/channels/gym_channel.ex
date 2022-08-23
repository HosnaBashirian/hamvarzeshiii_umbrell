defmodule HamVarzeshiWeb.GymChannel do
  use Phoenix.Channel

  # alias HamVarzeshiWeb.Presence
  alias HamVarzeshi.Chats
  # alias ChatApp.Chats.Message

  alias HamVarzeshi.{Accounts, Chats, Gyms}

  def join("gym:" <> gym_id, _params, socket) do
      IO.inspect %{IS: gym_id}
      {:ok, socket}
  end

  def handle_in("message:add", %{"body" => body}, %{topic: "gym:" <> gym_id, assigns: %{user_id: user_id}} = socket) do
    IO.inspect socket
    gym = Gyms.get_gym!(gym_id)
    user = Accounts.get_user(user_id)
    # IO.inspect user_id

    case Chats.create_message(user, gym, %{body: body}) do
      {:ok, message} ->
        message_template = %{body: message.body, username: user.username}
        broadcast!(socket, "new_message", message_template)
        {:reply, :ok, socket}

      {:error, _} ->
        {:reply, :error, socket}
    end
    {:noreply, socket}
  end
 end
