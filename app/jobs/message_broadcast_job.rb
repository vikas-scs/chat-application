class MessageBroadcastJob < ApplicationJob
    queue_as :default

  def perform(message)
    sender = message.user
    recipient = message.conversation.opposed_user(sender)
    broadcast_to_recipient(recipient, message)
    broadcast_to_sender(sender, message)
    
  end

  private

  def broadcast_to_sender(user, message)
  	puts user.id
  	puts "1 st"
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      message: render_message(message, user),
      conversation_id: message.conversation_id
    )
  end

  def broadcast_to_recipient(user, message)
  	puts user.id
  	puts "2nd"
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      message: render_message(message, user),
      conversation_id: message.conversation_id
    )
  end

  def render_message(message, user)
   ApplicationController.render_with_signed_in_user(
      message.user, partial: 'messages/message', locals: { message: message, user: user }
    )
  end  
end
