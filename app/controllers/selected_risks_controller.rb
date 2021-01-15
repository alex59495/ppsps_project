class SelectedRisksController < ApplicationController
  before_action :find_ppsp

  def create
    # For each element from the view ppsp/informations_supplementaire which were selected
    params_selected_risks.each do |risk|
      @selected_risk = SelectedRisk.new(risk_id: risk)
      @selected_risk.ppsp_id = @ppsp.id
      authorize @selected_risk
      @selected_risk.save
    end
    redirect_to informations_supplementaires_ppsp_path(@ppsp)
    # A CORRIGER CETTE PARTIE
    #   redirect_to ppsp_selected_risk_path
    # else
    #   render 'ppsp/informations_supplementaires.html.erb'
    # end
  end

  def destroy
    @selected_risk = SelectedRisk.find(params[:id])
    authorize @selected_risk
    @selected_risk.destroy
    # Add a params to know if we are coming back to the info supp page from a destroy action
    redirect_to informations_supplementaires_ppsp_path(@ppsp, destroy: true)
  end

  private

  def params_selected_risks
    params.require(:selected_risk).require(:risk_id)
  end

  def find_ppsp
    @ppsp = Ppsp.find(params[:ppsp_id])
  end
end
