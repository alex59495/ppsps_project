class RegionalCommitteesController < ApplicationController
  before_action :find_regional_committee, only: [ :update, :show, :destroyed, :edit ]

  def index
    authorize RegionalCommittee
    @regional_committees = policy_scope(RegionalCommittee.where(is_destroyed: false))
    @regional_committee = RegionalCommittee.new
  end

  def create
    @regional_committee = RegionalCommittee.new(params_regional_committee)
    @regional_committee.company = current_user.company
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

  def destroyed
    authorize @regional_committee
    @regional_committee.is_destroyed = true
    if @regional_committee.save
      redirect_to regional_committees_path
    else
      flash.now[:error] = "L'élément n'a pas pu être supprimé"
    end
  end

  private
  def params_regional_committee
    params.require(:regional_committee).permit(:address, :name, :phone, :fax, :company)
  end

  def find_regional_committee
    @regional_committee = RegionalCommittee.find(params[:id])
  end
end
