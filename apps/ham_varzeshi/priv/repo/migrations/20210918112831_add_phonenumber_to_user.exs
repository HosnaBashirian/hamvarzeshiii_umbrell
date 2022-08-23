defmodule HamVarzeshi.Repo.Migrations.AddPhonenumberToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
    add :phonenumber, :string
    end
  end
end
