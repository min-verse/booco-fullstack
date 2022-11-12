class BookChatsController < ApplicationController
    before_action :authenticate_user!

    # GET /all_bookchats/:id
    def index
        # chats = Chat.where(user_id:params[:user_id]).order(:created_at)
        part_one = BookChat.where(user:current_user).where(friend_id:params[:id])
        part_two = BookChat.where(friend:current_user).where(user_id:params[:id])
        chats = part_one + part_two
        render json: chats.sort_by(&:created_at), status: :ok
    end

    # POST /bookchats
    def create
        puts params[:room]
        new_chat = BookChat.create!(user:current_user, friend_id:params[:friend], message:params[:message])
        if new_chat.valid?
            # broadcast the new chat message to any subscribers of our ActionCable channel
            # to broadcast to a specific channel or subscribers use the following syntax
            
            # we use current_user to identify WHO made that tweet
            # then the data we're going to send (broadcast) is that actual chat message data: new_chat
            # now IN ADDITION TO (1) creating a new chat and sending a JSON of the newly-created chat back, now we can ALSO
            # (2) BROADCAST that newly-created chat to the channels
            # ChatsChannel.broadcast_to(params[:room], new_chat)
            message_to_send_back = {id:new_chat.id, user_id:current_user.id, username:current_user.username, message:params[:message]}
            ActionCable.server.broadcast(params[:room], message_to_send_back)
            render json: new_chat, status: :ok
        else
            render json: new_chat.errors.full_messages, status: :unprocessable_entity
        end
    end
end
