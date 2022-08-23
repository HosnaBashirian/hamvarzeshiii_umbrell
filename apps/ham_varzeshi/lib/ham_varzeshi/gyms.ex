defmodule HamVarzeshi.Gyms do
  @moduledoc """
  The Gyms context.
  """
  import Ecto.Query, warn: false
  alias HamVarzeshi.Repo
  alias HamVarzeshi.Gyms.Gym
  alias HamVarzeshi.Accounts
  # alias HamVarzeshi.Chats.Message

  @doc """
  Returns the list of Gyms.

  ## Examples
      iex> list_gyms()
      [%Gym{}, ...]

  """
  def list_gyms do
    Repo.all(Gym)
  end

  def list_user_gyms(%Accounts.User{} = user) do
    Gym
    |> user_gyms_query(user)
    |> Repo.all()
  end

  def get_user_gym!(%Accounts.User{} = user, id) do #for properly locking down access
    Gym
    |> user_gyms_query(user)
    |> Repo.get!(id)
  end

  @doc """
  Gets a single Gym.

  Raises `Ecto.NoResultsError` if the Gym does not exist.

  ## Examples

      iex> get_gym!(123)
      %Gym{}

      iex> gym!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gym!(id), do: Repo.get!(Gym, id)

  defp user_gyms_query(query, %Accounts.User{id: user_id}) do
    from(v in query, where: v.user_id == ^user_id)
  end

  @doc """
  Creates a Gym.

  ## Examples

      iex> create_gym(%{field: value})
      {:ok, %Gym{}}

      iex> create_gym(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gym(%Accounts.User{} = user, attrs \\ %{}) do
    %Gym{}
    |> Gym.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Updates a Gym.

  ## Examples

      iex> update_gym(Gym, %{field: new_value})
      {:ok, %Gym{}}

      iex> update_gym(Gym, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gym(%Gym{} = gym, attrs) do
    gym
    |> Gym.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Gym.

  ## Examples

      iex> delete_gym(Gym)
      {:ok, %Gym{}}

      iex> delete_gym(Gym)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gym(%Gym{} = gym) do
    Repo.delete(gym)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Gym changes.

  ## Examples

      iex> change_gym(Gym)
      %Ecto.Changeset{data: %Gym{}}

  """
  def change_gym(%Gym{} = gym, attrs \\ %{}) do
    Gym.changeset(gym, attrs)
  end

  def compare_gym_time() do

    current_time = System.os_time(:second)
    IO.inspect current_time
    compute_time = to_string (current_time + 1800)
    compute_extra_time = to_string(current_time + 1860)
    # user_turn = from(g in Gym, where: g.start_time >= ^compute_turn and g.start_time, select: %{user_id: g.user_id, start_time: g.start_time}) |> Repo.all
    user_turn = from(g in Gym, where: ^compute_time <= g.start_time and g.start_time <= ^compute_extra_time, select: [:user_id])
     |> Repo.all
     |> Repo.preload(:user)
    end

  # def get_ratings() do
  #   Repo.all(Rating)
  # end

  # def get_rating(id) do
  #   Rating
  #   |> Repo.get! id
  # end
end
