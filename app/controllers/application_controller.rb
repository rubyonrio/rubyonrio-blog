class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :set_content_type

  protected

  def set_content_type
    headers['Content-Type'] ||= 'text/html; charset=utf-8'
  end

  def enki_config
    @@enki_config = Enki::Config.default
  end
  helper_method :enki_config

  def mobile?
    request.headers["HTTP_USER_AGENT"].include?(("iPhone" or "BlackBerry" or "SymbianOS" or "Android")) unless (params[:mobile] == "false")
  end
  helper_method :mobile?

  def mobile_view_path
    prepend_view_path "app/views/mobile" if mobile?
  end
end
