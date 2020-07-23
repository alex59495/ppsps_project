class SelectedAltitudesController < ApplicationController
  before_action :find_ppsp

  def create
    #For each element from the view ppsp/informations_supplementaire which were selected
    params_selected_altitudes.each do |work|
      @selected_altitude = SelectedAltitude.new(altitude_work_id: work)
      @selected_altitude.ppsp_id = @ppsp.id
      authorize @selected_altitude
      @selected_altitude.save
    end
    redirect_to informations_supplementaires_ppsp_path(@ppsp)
    # A CORRIGER CETTE PARTIE
    #   redirect_to ppsp_selected_altitude_path
    # else
    #   render 'ppsp/informations_supplementaires.html.erb'
    # end
  end

  def destroy
    @selected_altitude = SelectedAltitude.find(params[:id])
    authorize @selected_altitude
    @selected_altitude.destroy
    redirect_to informations_supplementaires_ppsp_path(@ppsp)
  end

  private
  def params_selected_altitudes
    params.require(:selected_altitude).require(:altitude_work_id)
  end

  def find_ppsp
    @ppsp = Ppsp.find(params[:ppsp_id])
  end
end
