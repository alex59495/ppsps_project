class MoesController < ApplicationController
  before_action :find_moe, only: [ :update, :show, :destroy, :edit ]

  def index
    @moes = policy_scope(Moe.where(company: current_user.company))
    @moe = Moe.new
  end

  def create
    @moe = Moe.new(params_moe)
    @moe.company = current_user.company
    authorize @moe
    if @moe.save
      # Create an ordered list to use in the view 'moe/_form_field_moe'
      @moes = Moe.all.sort_by { |moe| moe.name.downcase }
      # Respond with the view moe/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_moe' }
      end
    end
  end

  def edit
    authorize @moe
  end

  def update
    authorize @moe
    if @moe.update(params_moe)
      redirect_to moes_path
    else
      render :edit
    end
  end

  def destroy
    authorize @moe
    @moe.destroy
    redirect_to moes_path
  end

  private
  def params_moe
    params.require(:moe).permit(:address, :name, :phone, :email, :representative, :company)
  end

  def find_moe
    @moe = Moe.find(params[:id])
  end
end
