defmodule HamVarzeshiWeb.Presence do

  use Phoenix.Presence, otp_app: :chat_app,
                        pubsub_server: HamVarzeshi.PubSub
end
