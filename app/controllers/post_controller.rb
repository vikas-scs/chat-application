class PostController < ApplicationController
	def add_post                     
		if params[:post].empty?
			flash[:notice] = "post can't be empty!!!!"
			redirect_to root_path
			return
		end
		@post = Post.new                      #adding new post two user
		@post.text = params[:post]
		@post.user_id = current_user.id
		if @post.save
			flash[:alert] = "Post Added Successful!!!"
			redirect_to root_path
			return
		end
	end
	def show_post                      #getting the posts of friends
		@friends = Friend.where(user_id: current_user.id, friend_id: params[:id]).first
		@friend = User.find(params[:id])
		if !@friends.present?
			flash[:notice] = "#{@friend.first_name} and You are no longer friends!!!"
			redirect_to my_friends_path
			return
		end
		@posts = @friend.posts	
	end
	def commet                        #commentting for the post created by friend
		if params[:comment].empty?
			flash[:notice] = "comment can't be empty!!!!"
			redirect_to show_post_path(id: params[:post_id])
			return
		end
		@comment = Comment.new
		@comment.text = params[:comment]
		@comment.post_id = params[:post_id]
		@comment.user_id = current_user.id
		if @comment.save
		    flash[:alert] = "comment added to post!!!!"
			redirect_to show_post_path(id: params[:friend_id])
			return
		end	
	end
end
