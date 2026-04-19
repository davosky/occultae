class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :authenticate_supervisor!

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.js { head :forbidden }
    end
  end
end
