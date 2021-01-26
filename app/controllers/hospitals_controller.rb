class HospitalsController < DatabaseController

  def update
    @path = hospitals_path
    super
  end

  def destroyed
    @path = hospitals_path
    super
  end

  def init_infinite_scroll
    @pagination_path = pagination_hospitals_path
    super
  end
end
