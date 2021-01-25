class AntiPoisonsController < DatabaseController
  def update
    @path = anti_poisons_path
    super
  end

  def destroyed
    @path = anti_poisons_path
    super
  end

  def init_infinite_scroll
    @pagination_path = pagination_anti_poisons_path
    super
  end
end
