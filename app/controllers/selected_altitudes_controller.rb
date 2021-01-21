class SelectedAltitudesController < ApplicationController
  before_action :find_ppsp

  def create
    # For each element from the view ppsp/informations_supplementaire which were selected
    params_selected_altitudes.each do |work|
      # If work is an ID of the altitude work
      if id?(work)
        @selected_altitude = SelectedAltitude.new(altitude_work_id: work)
        @selected_altitude.ppsp_id = @ppsp.id
        authorize @selected_altitude
        @selected_altitude.save
      else
        # If work is a value entered by the user
        altitude_work = AltitudeWork.find_by(name: "Autre")
        @selected_altitude = SelectedAltitude.new(altitude_work_id: altitude_work.id, other: work)
        @selected_altitude.ppsp_id = @ppsp.id
        authorize @selected_altitude
        @selected_altitude.save
      end
    end
    redirect_to informations_supplementaires_ppsp_path(@ppsp, ajout: true)
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
    # Add a params to know if we are coming back to the info supp page from a destroy action
    redirect_to informations_supplementaires_ppsp_path(@ppsp, destroy: true)
  end

  private

  def params_selected_altitudes
    array = params.require(:selected_altitude).require(:altitude_work_id)
    array.reject { |c| c.empty? }
  end

  def id?(value)
    # if value.to_i is sup a 0, means that it is an id, if it is = 0 means that it is a string
    value.to_i > 0
  end

  def find_ppsp
    @ppsp = Ppsp.find(params[:ppsp_id])
  end
end
