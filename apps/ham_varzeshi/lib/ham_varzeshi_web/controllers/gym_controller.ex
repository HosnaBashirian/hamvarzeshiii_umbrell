defmodule HamVarzeshiWeb.GymController do
  use HamVarzeshiWeb, :controller

  alias HamVarzeshi.Gyms.Gym
  alias HamVarzeshi.Gyms
  alias HamVarzeshi.Chats

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, current_user) do
    gyms = Gyms.list_user_gyms(current_user)
    render(conn, "index.html", gyms: gyms)
  end

  def new(conn, _params, current_user) do
    changeset = Gyms.change_gym(%Gym{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"gym" => gym_params}, current_user) do
    case Gyms.create_gym(current_user, gym_params) do
      {:ok, _gym} ->
        conn
        |> put_flash(:info, "gym created successfully.")
        |> redirect(to: Routes.gym_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    gym = Gyms.get_user_gym!(current_user, id)
    messages = Chats.list_messages()
    IO.inspect conn
    render(conn, "show.html", gym: gym, messages: messages)
  end

  def edit(conn, %{"id" => id}, current_user) do
    gym = Gyms.get_user_gym!(current_user, id)
    changeset = Gyms.change_gym(gym)
    render(conn, "edit.html", gym: gym, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gym" => gym_params}, current_user) do
    gym = Gyms.get_user_gym!(current_user, id)

    case Gyms.update_gym(id, gym_params) do
      {:ok, _gym} ->
        conn
        |> put_flash(:info, "gym updated successfully.")
        |> redirect(to: Routes.gym_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", gym: gym, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    gym = Gyms.get_user_gym!(current_user, id)
    {:ok, _gym} = Gyms.delete_gym(gym)

    conn
    |> put_flash(:info, "gym deleted successfully.")
    |> redirect(to: Routes.gym_path(conn, :index))
  end
end
