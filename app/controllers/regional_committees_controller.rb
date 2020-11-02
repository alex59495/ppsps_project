class RegionalCommitteesController < ApplicationController
  before_action :find_regional_committee, only: [ :update, :show, :destroy, :edit ]

  def index
    @regional_committees = policy_scope(RegionalCommittee)
    @regional_committee = RegionalCommittee.new
  end

  def show
    authorize @regional_committee
  end

  def create
    @regional_committee = RegionalCommittee.new(params_regional_committee)
    authorize @regional_committee
    if @regional_committee.save
      # Create an ordered list to use in the view 'regional_committee/_form_field_regional_committee'
      @regional_committees = RegionalCommittee.all.sort_by { |regional_committee| regional_committee.name }
      # Respond with the view regional_committee/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_regional_committee' }
      end
    end
  end
  
  def edit
    authorize @regional_committee
  end

  def update
    authorize @regional_committee
    if @regional_committee.update(params_regional_committee)
      redirect_to regional_committees_path
    else
      render :edit
    end
  end

  def destroy
    authorize @regional_committee
    @regional_committee.destroy
    redirect_to regional_committees_path
  end

  private
  def params_regional_committee
    params.require(:regional_committee).permit(:address, :name, :phone, :fax)
  end

  def find_regional_committee
    @regional_committee = RegionalCommittee.find(params[:id])
  end
end
