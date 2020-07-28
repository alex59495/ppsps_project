class SubResponsiblesController < ApplicationController
  def new
    @sub_responsible = SubResponsible.new
    authorize @sub_responsible
  end

  def create
    @sub_responsible = SubResponsible.new(params_sub_responsible)
    authorize @sub_responsible
    if @sub_responsible.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  private
  def params_sub_responsible
    params.require(:sub_responsible).permit(:name, :phone, :email)
  end
end
