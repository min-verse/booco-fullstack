class PostSerializer < ActiveModel::Serializer
    attributes :id, :user, :book, :title, :content, :created_at, :number_of_comments, :time

    belongs_to :book
    
    # this code might make the call stack too big
    has_many :comments

    def user
      {id:self.object.user.id, username:self.object.user.username, avatar:self.object.user.avatar}
    end

    def number_of_comments
      self.object.comments.length
    end

    def time
      self.object.created_at.strftime("%a, %d %b %Y %H:%M:%S")
    end
end
