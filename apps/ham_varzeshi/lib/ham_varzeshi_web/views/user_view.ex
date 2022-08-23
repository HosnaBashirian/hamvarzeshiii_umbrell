defmodule HamVarzeshiWeb.UserView do
  use HamVarzeshiWeb, :view

  alias HamVarzeshi.Accounts

  def user_info(%Accounts.User{name: name})
  do name
  |> String.split(" ")
  |> Enum.at(0)
  end
end
