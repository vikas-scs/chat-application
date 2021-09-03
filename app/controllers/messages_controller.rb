class MessagesController < ApplicationController
	def create
		@conversation = Conversation.includes(:recipient).find(params[:conversation_id])
		puts @conversation.id
		@message = @conversation.messages.create(message_params)                #creating the message to perform action cable dynamic message sending through jobs
        puts @message.inspect
		respond_to do |format|
            format.js
        end
	end
	def message_params
		params.require(:message).permit(:user_id, :content)
	end
end
