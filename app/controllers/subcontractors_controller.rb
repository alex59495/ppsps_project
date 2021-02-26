class SubcontractorsController < DatabaseController
  def update
    @path = subcontractors_path
    super
  end

  def destroyed
    @path = subcontractors_path
    super
  end

  def init_infinite_scroll
    @pagination_path = pagination_subcontractors_path
    super
  end

  def create
    # We need an "@data" to render the correct partial in views
    @data = @model_name.new(params_data)
    # In the case of selected_tables we don't have the instance, only the id so we add the 'OR'
    @data.company_id = current_user.company.id
    authorize @data
    instance_variable_creation(@data)
    @search = "none"
    @subcontractors = policy_scope(Subcontractor.all)
    if @data.save
      # Create an ordered list to put the last one in first
      @database = policy_scope(@model_name.all).sort_by { |datab| datab.created_at }
      # Useful for the infinite scroll, wh have to do it because we re-render the page after the action
      init_infinite_scroll
      # Respond with the view anti_poison/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js { render "#{controller_name}/create.js.erb" }
      end
    else
      # What to do ?
    end
  end
end
