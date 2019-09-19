class ChatChannel < ApplicationCable::Channel
  def subscribed
    puts "CHANNEL SUBSCRIBED\n"*5
    stream_from "chat"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
