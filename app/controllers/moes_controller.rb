class MoesController < DatabaseController
  def update
    @path = moes_path
    super
  end

  def destroyed
    @path = moes_path
    super
  end

  def init_infinite_loop
    @pagination_path = pagination_moes_path
    super
  end
end
