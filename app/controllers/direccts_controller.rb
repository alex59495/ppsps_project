class DirecctsController < DatabaseController
  def update
    @path = direccts_path
    super
  end

  def destroyed
    @path = direccts_path
    super
  end

  def init_infinite_loop
    @pagination_path = pagination_direccts_path
    super
  end
end
