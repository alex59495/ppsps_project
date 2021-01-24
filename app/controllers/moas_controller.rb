class MoasController < DatabaseController
  def update
    @path = moas_path
    super
  end

  def destroyed
    @path = moas_path
    super
  end

  def init_infinite_loop
    @pagination_path = pagination_moas_path
    super
  end
end
