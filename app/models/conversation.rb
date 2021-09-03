class Conversation < ApplicationRecord
	has_many :messages, dependent: :destroy
    belongs_to :sender, foreign_key: :sender_id, class_name: "User"
    belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"

	after_update do |conversation|
       @version = Version.last
       @table = @version.item_type
       @column = @version.object_changes[/\n(.*?):\n/,1]
       @old_value = @version.object_changes[/:\n- (.*?)\n/,1]
       @new_value = @version.object_changes[/\n- (.*?)\nupdated_at/,1]
       @admin = @version.whodunnit
       UserMailer.with(table: @table, column: @column, old_value: @old_value, new_value: @new_value,admin_id: @admin).changes_email.deliver_now
    end
    validates :sender_id, uniqueness: { scope: :recipient_id }

     scope :between, -> (sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
    end

      def self.get(sender_id, recipient_id)
       conversation = between(sender_id, recipient_id).first
      return conversation if conversation.present?

       create(sender_id: sender_id, recipient_id: recipient_id)
     end

    def opposed_user(user)
       user == recipient ? sender : recipient
     end
end
