class ApplicationController < ActionController::Base
  
	before_action :set_paper_trail_whodunnit
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :set_last_seen_at, if: :user_signed_in?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :mobile])  
  end
	def after_sign_in_path_for(resource)
    # check for the class of the object to determine what type it is
    case resource.class.to_s
      when "User"
    	root_path
      # new_user_session_path  
      when "Admin"
    	rails_admin_path
      # new_admin_session_path
    end
  end
  protected
  def set_last_seen_at
  	 current_user.touch(:last_seen_at)
  end
  def self.render_with_signed_in_user(user, *args)
       ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
       proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
       renderer = self.renderer.new('warden' => proxy)
       renderer.render(*args)
     end
end
