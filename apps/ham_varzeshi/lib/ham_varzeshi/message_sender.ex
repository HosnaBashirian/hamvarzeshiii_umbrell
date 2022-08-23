defmodule HamVarzeshi.MessageSender do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_state) do
    {:ok, nil}
  end

  def handle_cast({:send, phonenumber}, state) do

   HTTPoison.get("https://api.kavenegar.com/v1/75333638646D727756676C784331536F676E47547351734C4C44394E682F335A6C573771346F582B3075343D/sms/send.json?receptor=09366360344&message=gym%20time")
    IO.inspect "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
   {:noreply, state}

  end

  def send_message_faliure({_reminders, 3}), do: IO.puts("message terminated :(")

  def http_send_message_faliure({reminders, count}) do
    IO.puts("Failed completly >:(")
    Process.send_after(MessageSender, {:send, reminders, count}, 20000)
  end

end
