class SosHandsController < DatabaseController
  def update
    @path = sos_hands_path
    super
  end

  def destroyed
    @path = sos_hands_path
    super
  end

  def init_infinite_loop
    @pagination_path = pagination_sos_hands_path
    super
  end
end
