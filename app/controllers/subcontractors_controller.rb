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
end
