defmodule HamVarzeshiWeb.GymView do
  use HamVarzeshiWeb, :view

  def gym_info(%HamVarzeshi.Gyms.Gym{name: name}) do name
    |> String.split(" ")
    |> Enum.at(0)
  end
  # def rating_select_options(ratings) do
  #   for rating <- ratings, do: {rating.rate, rating.id}
  # end
end
