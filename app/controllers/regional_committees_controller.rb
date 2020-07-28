class RegionalCommitteesController < ApplicationController
  def index
    @regional_committees = policy_scope(RegionalCommittee)
  end

  def new
    @regional_committee = RegionalCommittee.new
    authorize @regional_committee
  end

  def create
    @regional_committee = RegionalCommittee.new(params_regional_committee)
    authorize @regional_committee
    if @regional_committee.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  private
  def params_regional_committee
    params.require(:regional_committee).permit(:address, :name, :phone, :fax)
  end
end
