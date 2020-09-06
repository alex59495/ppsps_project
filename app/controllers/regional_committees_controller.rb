class RegionalCommitteesController < ApplicationController
  before_action :find_regional_committee, only: [ :update, :show, :destroy, :edit ]

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

  private
  def params_regional_committee
    params.require(:regional_committee).permit(:address, :name, :phone, :fax)
  end

  def find_regional_committee
    @regional_committee = RegionalCommittee.find(params[:id])
  end
end
