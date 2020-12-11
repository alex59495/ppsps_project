class HospitalsController < ApplicationController
  before_action :find_hospital, only: [ :update, :show, :destroyed, :edit ]
  
  def index
    authorize Hospital
    if params[:query]
      @hospitals = policy_scope(Hospital.search_hospital(params[:query]))
      # We are using form_with in the index view so it respond with ajax, to handle the response we have to activate a format response
      respond_to do |format|
        # Respond with the index.js.erb
        format.js {}
      end
    else
      @hospitals = policy_scope(Hospital.all)
      # Must be able to respond in HTML (when load the page) and JS (when click on button Show all databse)
      respond_to do |format|
        format.html {}
        format.js {}
      end
    end

    # Useful for the infinite scroll
    @hospitals_page = @hospitals.page
    @endpoint = pagination_hospitals_path
    @page_amount = @hospitals_page.total_pages

    @hospital = Hospital.new
  end

  def create
    @hospital = Hospital.new(params_hospital)
    @hospital.company = current_user.company
    authorize @hospital
    if @hospital.save
      # Create an ordered list to use in the view 'hospital/_form_field_hospital'
      @hospitals = Hospital.all.sort_by { |hospital| hospital.name.downcase }
      # Respond with the view hospital/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_hospital' }
      end
    end
  end

  def edit
    authorize @hospital
  end

  def update
    authorize @hospital
    if @hospital.update(params_hospital)
      redirect_to hospitals_path
    else
      render :edit
    end
  end

  def destroyed
    authorize @hospital
    @hospital.is_destroyed = true
    if @hospital.save
      redirect_to hospitals_path
    else
      flash.now[:error] = "L'élément n'a pas pu être supprimé"
    end
  end

  def pagination
    if params[:query]
      @hospitals = policy_scope(Hospital.search_hospital(params[:query]))
    else
      @hospitals = policy_scope(Hospital.all)
    end
    authorize @hospitals
    @hospitals_page = @hospitals.page(params[:page])
    render 'hospitals/_element', collection: @hospitals_page, layout: false
  end

  private
  def params_hospital
    params.require(:hospital).permit(:address, :name, :phone, :company)
  end

  def find_hospital
    @hospital = Hospital.find(params[:id])
  end
end
