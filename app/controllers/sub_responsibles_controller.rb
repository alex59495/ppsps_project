class SubResponsiblesController < ApplicationController
  before_action :find_sub_responsible, only: [ :update, :show, :destroy, :edit ]

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

  def edit
    authorize @sub_responsible
  end

  def update
    authorize @sub_responsible
    if @sub_responsible.update(params_sub_responsible)
      redirect_to sub_responsibles_path
    else
      render :edit
    end
  end

  private
  def params_sub_responsible
    params.require(:sub_responsible).permit(:email, :name, :phone)
  end

  def find_sub_responsible
    @sub_responsible = SubResponsible.find(params[:id])
  end
end
