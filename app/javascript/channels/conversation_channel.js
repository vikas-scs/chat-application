import consumer from "./consumer"

consumer.subscriptions.create("ConversationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
     console.log(data);
     var conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");

    if (data['window'] !== undefined) {
      var conversation_visible = conversation.is(':visible');

      if (conversation_visible) {
        var messages_visible = (conversation).find('.panel-body').is(':visible');

        if (!messages_visible) {
          conversation.removeClass('panel-default').addClass('panel-success');
        }
        conversation.find('.messages-list').find('ul').append(data['message']);
      }
      else {
        $('#conversations-list').append(data['window']);
        conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
        conversation.find('.panel-body').toggle();
        console.log("if statement");
      }
    }
    else {
      conversation.find('ul').append(data['message']);
      console.log(data['message']);
      console.log("else statement");
    }

    var messages_list = conversation.find('.messages-list');
    var height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height);
  },
  speak: function(message) {
    return this.perform('speak', {
      message: message
    });
  }
});

