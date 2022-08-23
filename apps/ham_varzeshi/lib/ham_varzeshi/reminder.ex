defmodule HamVarzeshi.Reminder do
  use GenServer
  alias HamVarzeshi.Gyms

  def start_link do
    x = GenServer.start_link(HamVarzeshi.Reminder, [], name: HamVarzeshi.Reminder)#naming pid HamVarzeshi.Reminder
    Process.send_after(HamVarzeshi.Reminder, :msg, 1)
    x
  end

  def init(_) do
    HamVarzeshi.MessageSender.start_link
  {:ok, %{}}
  end

  def handle_call(:msg, _from, state) do
    # send another generic server near_gyms.map => phone_number, time, name, gym_name
    {:noreply, state}
  end

  def handle_info(:msg, state) do
    near_gyms = Gyms.compare_gym_time()

    for gym <- near_gyms do
      GenServer.cast(HamVarzeshi.MessageSender, {:send, gym.user.phonenumber})
    end
    # IO.inspect "#########################"
    Process.send_after(HamVarzeshi.Reminder, :msg, 2000)
    {:noreply, state}
  end
end
