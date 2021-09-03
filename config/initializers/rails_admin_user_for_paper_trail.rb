RailsAdmin::ApplicationController.module_eval do
  def user_for_paper_trail
    _current_user.try(:id) || _current_user
  end
end