class DeminingsController < DatabaseController
  def update
    @path = deminings_path
    super
  end

  def destroyed
    @path = deminings_path
    super
  end

  def init_infinite_scroll
    @pagination_path = pagination_deminings_path
    super
  end
end
