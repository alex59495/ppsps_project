class MoesController < DatabaseController
  def update
    @path = moes_path
    super
  end

  def destroyed
    @path = moes_path
    super
  end

  def init_infinite_scroll
    @pagination_path = pagination_moes_path
    super
  end
end
