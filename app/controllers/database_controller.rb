class DatabaseController < ApplicationController
  before_action :find, only: [ :update, :show, :destroyed, :edit ]

  def index
  authorize controller_name.classify.constantize
  if params[:query]
      @database = policy_scope(controller_name.classify.constantize.search(params[:query]))
      @search = 'search'
      # We are using form_with in the index view so it respond with ajax, to handle the response we have to activate a format response
      respond_to do |format|
        # Respond with the index.js.erb
        format.js {}
      end
    else
      @database = policy_scope(controller_name.classify.constantize.all)
      @search = 'none'
      # Must be able to respond in HTML (when load the page) and JS (when click on button Show all databse)
      respond_to do |format|
        format.html {}
        format.js {}
      end
    end
    # Useful for the infinite scroll
    init_infinite_loop
    @data = controller_name.classify.constantize.new
  end

  def create
    @data = controller_name.classify.constantize.new(params_data)
    @data.company = current_user.company
    authorize @data
    if @data.save
      # Create an ordered list to put the last one in first
      @database = policy_scope(controller_name.classify.constantize.all).sort_by { |data| data.created_at }
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
  end

  def update
    authorize @data
    if @data.update(params_data)
      redirect_to @path
    else
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
      @database = policy_scope(controller_name.classify.constantize.search(params[:query]))
    else
      @database = policy_scope(controller_name.classify.constantize.all)
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
    params.require(controller_name.chop.to_sym).permit(controller_name.classify.constantize.new.attributes.keys.map(&:to_sym))
  end

  def find
    @data = controller_name.classify.constantize.find(params[:id])
  end

end
