class DeminingsController < DatabaseController
  def update
    @path = deminings_path
    super
  end

  def destroyed
    @path = deminings_path
    super
  end

  def init_infinite_loop
    @pagination_path = pagination_deminings_path
    super
  end
end
