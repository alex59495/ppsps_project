class MoasController < DatabaseController
  def update
    @path = moas_path
    super
  end

  def destroyed
    @path = moas_path
    super
  end

  def init_infinite_scroll
    @pagination_path = pagination_moas_path
    super
  end
end
