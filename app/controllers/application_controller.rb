class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :authenticate_supervisor!

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render nothing: true, status: :not_found }
      format.html { redirect_to main_app.root_url, notice: exception.message, status: :not_found }
      format.js { render nothing: true, status: :not_found }
    end
  end
end
