class RoomController < ApplicationController
	def new
            session[:conversations] ||= []
            @friend = current_user.friends         #gettting rhe the current user friend list
            @users = Array.new         
            @friend.each do |f|
                 @user = User.find(f.friend_id)
                 @users << @user
            end  
            @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])
      end
end
