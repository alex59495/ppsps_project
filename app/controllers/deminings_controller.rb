class DeminingsController < ApplicationController
  before_action :find_demining, only: [ :update, :show, :destroy, :edit ]

  def index
    @deminings = policy_scope(Demining)
  end
  
  def new
    @demining = Demining.new
    authorize @demining
  end

  def create
    @demining = Demining.new(params_demining)
    authorize @demining
    if @demining.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  private
  def params_demining
    params.require(:demining).permit(:address, :name, :phone)
  end
end
