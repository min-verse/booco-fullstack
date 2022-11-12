class CommentSerializer < ActiveModel::Serializer
  attributes :id, :get_user, :get_post, :content, :created_at, :time

    belongs_to :user
    belongs_to :post

    def get_user
        self.object.user
    end

    def get_post
        self.object.post
    end

    def time
        self.object.created_at.strftime("%a, %d %b %Y %H:%M:%S")
    end
end
