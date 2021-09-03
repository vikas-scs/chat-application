class UserMailer < ApplicationMailer
	 default from: "sykamconsultancyservices@gmail.com"

	def welcome_email
       @user = User.find(params[:user_id])
       mail(to: @user.email, subject: 'Welcome to My Social Media')
    end
    def admin_email
    	@admin = Admin.find(params[:admin_id])
    	@old = params[:old_value]
    	mail(to: @admin.email, subject: 'changes in profile')
    end
    def changes_email
      @admin = Admin.where(role: "super_admin").first
      @old_value = params[:old_value]
      @new_value = params[:new_value]
      @changer = Admin.find(params[:admin_id].to_i)
      @column = params[:column]
      @table = params[:table]
      mail(to: @admin.email, subject: 'changes in table')  
    end
end
