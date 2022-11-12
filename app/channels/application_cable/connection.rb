module ApplicationCable
    class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user

      #if there's no token, then reject the connection
      unless request.params.key?('token') && request.params['token'].split(' ').size > 1
        reject_unauthorized_connection
      end

      # get the token from the URL params (see frontend code for this connection as well)
      token = request.params[:token].split(' ')[1]
      user_hash = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!, true, {algorithm:'HS256'})
      user_id = user_hash[0]["sub"].to_i

      # if there is such a user, then verify the connection
      if verified_user = User.find_by(id: user_id)
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
