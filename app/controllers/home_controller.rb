class HomeController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { sleep 1; render json: { msg: 'Computer says no' }, status: 501 }
    end
  end
end