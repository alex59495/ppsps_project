class SubcontractorsController < ApplicationController
  def new
    @subcontractor = Subcontractor.new
    authorize @subcontractor
  end

  def create
    @subcontractor = Subcontractor.new(params_subcontractor)
    authorize @subcontractor
    if @subcontractor.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  private
  def params_subcontractor
    params.require(:subcontractor).permit(:name, :phone, :email, :sub_responsible_id)
  end
end
