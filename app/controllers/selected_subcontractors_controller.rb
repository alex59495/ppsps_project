class SelectedSubcontractorsController < ApplicationController
  before_action :find_ppsp

  def create
    @subcontractor = Subcontractor.find(params[:subcontractor_id])
    @selected_subcontractor = SelectedSubcontractor.new(ppsp_id: @ppsp.id, subcontractor_id: @subcontractor.id)
    authorize @selected_subcontractor
    @selected_subcontractor.save
    redirect_to informations_supplementaires_ppsp_path(@ppsp)
  end

  def destroy
    @selected_subcontractor = SelectedSubcontractor.find(params[:id])
    authorize @selected_subcontractor
    @selected_subcontractor.destroy
    redirect_to informations_supplementaires_ppsp_path(@ppsp)
  end

  private
  def params_selected_subcontractors
    params.require(:selected_subcontractor).require(:subcontractor_id)
  end

  def find_ppsp
    @ppsp = Ppsp.find(params[:ppsp_id])
  end
end
