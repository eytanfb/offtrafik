class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  before_filter :set_locale_from_url

  private

  def set_locale_from_url
    if lang = request.env['HTTP_ACCEPT_LANGUAGE']
      lang = lang[/^[a-z]{2}/]
      lang = :"tr-TR" if lang == "tr"
    end
    I18n.locale = params[:locale] || lang || I18n.default_locale
  end
  
end
