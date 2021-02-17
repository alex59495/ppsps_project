class WorkersController < DatabaseController
  def update
    @path = workers_path
    super
  end

  def destroyed
    @path = workers_path
    super
  end

  def init_infinite_scroll
    @pagination_path = pagination_workers_path
    super
  end
end
