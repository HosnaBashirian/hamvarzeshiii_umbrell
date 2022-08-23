defmodule HamVarzeshi.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :text
      add :at, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :gym_id, references(:gyms, on_delete: :nothing)

      timestamps()
    end

    create index(:messages, [:user_id])
    create index(:messages, [:gym_id])
  end
end
