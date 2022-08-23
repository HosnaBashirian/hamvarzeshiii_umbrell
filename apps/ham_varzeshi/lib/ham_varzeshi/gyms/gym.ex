defmodule HamVarzeshi.Gyms.Gym do
  use Ecto.Schema
  import Ecto.Changeset
  use Arc.Ecto.Schema

  schema "gyms" do
    field :name, :string
    field :description, :string
    field :avatar, HamVarzeshi.AvatarGym.Type
    field :start_time, :string
    field :rating, :float
    field :hours, :integer

    belongs_to :user, HamVarzeshi.Accounts.User


    timestamps()
  end

  @doc false
  def changeset(gym, attrs) do
    gym
    |> cast(attrs, [:name, :description, :hours, :start_time, :rating])
    |> cast_attachments(attrs,[:avatar])
    |> validate_required([:name, :description, :hours, :start_time])
  end
end
