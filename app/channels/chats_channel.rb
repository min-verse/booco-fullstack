class ChatsChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    puts "SUBSCRIBED" * 10
    puts params
    stream_from params[:room]
  end

  def unsubscribed
    stop_all_streams
  end
end
