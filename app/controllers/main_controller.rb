class MainController < ApplicationController
  before_action :setup_js_configs
  def index 
    render html: '', layout: true
  end
end