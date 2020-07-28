class DirecctsController < ApplicationController
  def new
    @direcct = Direcct.new
    authorize @direcct
  end

  def create
    @direcct = Direcct.new(params_direcct)
    authorize @direcct
    if @direcct.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  private
  def params_direcct
    params.require(:direcct).permit(:address, :phone, :fax)
  end
end
