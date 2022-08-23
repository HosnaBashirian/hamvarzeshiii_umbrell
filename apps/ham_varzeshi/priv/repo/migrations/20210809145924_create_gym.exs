defmodule HamVarzeshi.Repo.Migrations.CreateGym do
  use Ecto.Migration

  def change do
    create table(:gyms) do
      add :avatar, :string
      add :name, :string
      add :description, :string
      add :start_time, :string
      add :hours, :integer
      add :rating, :float
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:gyms, [:user_id])


  end
end
