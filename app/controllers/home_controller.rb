class HomeController < ApplicationController
	def index
		if user_signed_in?
		    @posts = current_user.posts.order(created_at: :DESC)
		end
	end
	def send_request                                    #sending request to friend
        @fr = FriendRequest.where(user_id: current_user.id, friend_id: params[:id],status: "hold").first
        if @fr.present?
        	flash[:notice] = "Request already send before!!!"                   #chexking whether the request is accepted before
            redirect_to add_friends_path
            return
        end
        @addfriend = FriendRequest.new                                   #creating the friend request for two friends
        @addfriend.user_id = current_user.id
        @addfriend.friend_id = params[:id]
        @addfriend.status = "hold"
        if @addfriend.save
        	flash[:alert] = "Request Sent Successfully!!!"
            redirect_to add_friends_path
            return
        end
	end
	def my_requests            
		@fr = FriendRequest.where(friend_id: current_user.id,status: "hold")                 #checking for incoming friend requests
		@friends = Array.new
		@fr.each do |fr|
			@friend = User.find(fr.user_id)
			@friends << @friend
		end
	end
	def respond_request
		puts params.inspect
		if params[:status] == "accept"                              #checking whether the request is accepted or not
			@fr = FriendRequest.where(user_id: params[:friend_id], friend_id: current_user.id, status: "hold").first
			@friendsr = Friend.where(user_id: params[:friend_id],friend_id: current_user.id).first      #checking whether the request is already accepted
			if @friendsr.present?
			    flash[:notice] = "Request already accepted!!!"
                redirect_to respond_request_path
                return
            end
			@fr.status = "accept"
			@friend = Friend.new
			@friend.friend_id = current_user.id
			@friend.user_id = params[:friend_id]
			@friend1 = Friend.new
			@friend1.friend_id = params[:friend_id]
			@friend1.user_id = current_user.id
			@conversation = Conversation.new
			@conversation.sender_id = current_user.id
			@conversation.recipient_id = params[:friend_id]
			@conversation.save                        #creating the conversations between two users
			@fr.save
			if @friend.save
				@friend1.save
				flash[:alert] = "Request Accepted!!!"
                redirect_to my_friends_path
               return
            end
        elsif params[:status] = "reject"                  #procedence after the request is rejected
         	@fr = FriendRequest.where(user_id: params[:friend_id], friend_id: current_user.id,status: "hold").first
			@fr.status = "reject"
			if @fr.save
                flash[:notice] = "Request Rejected!!!"
                redirect_to my_requests_path
                return
            end
        end
	end
	def my_friends                                    
		@friend = current_user.friends                     #getting the currrent user friends
		@friends = Array.new
		@friend.each do |f|
		     @user = User.find(f.friend_id)
		     @friends << @user
		end		
	end
	def add_friends                
		@all = User.all                                #getting add request page info for available users
		@friends = Array.new
		@friend = current_user.friends
		  if !@friend.empty?
		        @friend.each do |f|
		            @user = User.find(f.friend_id)
		            @friends << @user
		        end
                @use = @all + @friends
                @allfriends = @use - (@all&@friends)
                @users = @allfriends.compact
            else
        	    @users = User.all
        end
	end
	def unfriend                                #removing the user from the friend list
		@friend = Friend.where(user_id: current_user.id, friend_id: params[:id]).first
		@friend1 = Friend.where(user_id: params[:id], friend_id: current_user.id).first
		@frien = User.find(params[:id])
		@conversation = Conversation.where(sender_id: current_user.id, recipient_id: params[:id]).first
		if !@conversation.present?
			@conversation = Conversation.where(sender_id: params[:id], recipient_id: current_user.id).first
		end
		if !@friend1.present? || !@friend.present?
			flash[:alert] = "#{@frien.first_name} is already removed before"
            redirect_to my_friends_path
            return
        end	
		puts @conversation.inspect
		p @friend.inspect
		p @friend1.inspect
		p current_user.id
		p params[:id]
		@friend.destroy
		@friend1.destroy
		@conversation.messages.destroy_all
		if @conversation.destroy
			flash[:alert] = "#{@frien.first_name} is removed from your friend list"
                redirect_to my_friends_path
               return
        end	
	end

end
