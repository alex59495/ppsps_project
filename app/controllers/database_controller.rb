class DatabaseController < ApplicationController
  before_action :model_name, except: %i[update destroyed edit find]
  before_action :find, only: %i[update destroyed edit]

  def index
    authorize @model_name
    if params[:query]
      @database = policy_scope(@model_name.search(params[:query]))
      @search = 'search'
      # We are using form_with in the index view so it respond with ajax, to handle the response we have to activate a format response
      respond_to do |format|
        # Respond with the index.js.erb
        format.js
      end
    else
      @database = policy_scope(@model_name.all)
      @search = 'none'
      # Must be able to respond in HTML (when load the page) and JS (when click on button Show all databse)
      respond_to do |format|
        format.html
        format.js
      end
    end
    # Useful for the infinite scroll
    init_infinite_loop
    @data = @model_name.new
    instance_variable_creation(@data)
  end

  def create
    data = @model_name.new(params_data)
    data.company = current_user.company
    authorize data
    instance_variable_creation(data)
    @search = "none"
    if data.save
      # Create an ordered list to put the last one in first
      @database = policy_scope(@model_name.all).sort_by { |datab| datab.created_at }
      # Useful for the infinite scroll, wh have to do it because we re-render the page after the action
      init_infinite_loop
      # Respond with the view anti_poison/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js { render "#{controller_name}/create.js.erb" }
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render "ppsps/modal_#{controller_name.chop}" }
      end
    end
  end

  def edit
    authorize @data
    instance_variable_creation(@data)
  end

  def update
    authorize @data
    instance_variable_creation(@data)
    if @data.update(params_data)
      redirect_to @path
    else
      # render error is possible with remote true thanks to turbolinks-render
      render :edit
    end
  end

  def destroyed
    authorize @data
    @data.is_destroyed = true
    if @data.save
      redirect_to @path
    else
      flash.now[:error] = "L'élément n'a pas pu être supprimé"
    end
  end

  # Useful for the infinite loop
  def pagination
    if params[:query]
      @database = policy_scope(@model_name.search(params[:query]))
    else
      @database = policy_scope(@model_name.all)
    end
    authorize @database
    @database_page = @database.page(params[:page])
    render "#{controller_name}/_elements", collection: @database_page, layout: false
  end

  private

  def init_infinite_loop
    # Useful for the infinite scroll
    @database_page = Kaminari.paginate_array(@database).page
    @endpoint = @pagination_path
    @page_amount = @database_page.total_pages
  end

  def params_data
    params.require(controller_name.chop.to_sym).permit(@model_name.new.attributes.keys.map(&:to_sym))
  end

  def find
    model_name
    @data = @model_name.find(params[:id])
  end

  # Methode to obtain the class of the child controller. We used #chop cause for moes case, #classifty delete 's' and 'e' (plural -> singular)
  def model_name
    @model_name = controller_name.chop.classify.constantize
  end

  # Create an instance variable for the child controller.
  def instance_variable_creation(data)
    instance_variable_set("@#{controller_name.chop}", data)
  end
end
