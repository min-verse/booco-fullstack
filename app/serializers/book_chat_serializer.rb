class BookChatSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :username, :message, :time

    def username
        self.object.user.username
    end

    def time
      self.object.created_at.strftime("%a, %d %b %Y %H:%M:%S")
    end
end
