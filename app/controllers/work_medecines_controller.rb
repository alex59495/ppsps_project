class WorkMedecinesController < DatabaseController
  def update
    @path = work_medecines_path
    super
  end

  def destroyed
    @path = work_medecines_path
    super
  end

  def init_infinite_scroll
    @pagination_path = pagination_work_medecines_path
    super
  end
end
