defmodule HamVarzeshi.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :body, :string

    belongs_to :gym, HamVarzeshi.Gym
    belongs_to :user, HamVarzeshi.Accounts.User

    timestamps()
  end


  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
