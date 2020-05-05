class ApplicationController < ActionController::Base
  def process_and_respond( operation )
    if result = operation.process
      yield operation, result
    else
      respond_to do |format|
        format.html {
          flash[:errors] = operation.errors
          redirect_back fallback_location: root_path
        }
        format.json { render json: {success: false, errors: operation.errors }, status: 422 }
      end
    end
  end

  protected

  def setup_js_configs
    gon.config = {
      gmap_api_key: ENV['GMAP_KEY']
    }
  end

end
