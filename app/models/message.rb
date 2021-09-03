class Message < ApplicationRecord
	belongs_to :user
	belongs_to :conversation
	has_paper_trail
	after_create_commit { MessageBroadcastJob.perform_later(self) }
	after_update do |message|
       @version = Version.last
       @table = @version.item_type
       @column = @version.object_changes[/\n(.*?):\n/,1]
       @old_value = @version.object_changes[/:\n- (.*?)\n/,1]
       @new_value = @version.object_changes[/\n- (.*?)\nupdated_at/,1]
       @admin = @version.whodunnit
       UserMailer.with(table: @table, column: @column, old_value: @old_value, new_value: @new_value,admin_id: @admin).changes_email.deliver_now
    end
end
