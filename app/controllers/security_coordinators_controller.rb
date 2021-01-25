class SecurityCoordinatorsController < DatabaseController
  def update
    @path = security_coordinators_path
    super
  end

  def destroyed
    @path = security_coordinators_path
    super
  end

  def init_infinite_scroll
    @pagination_path = pagination_security_coordinators_path
    super
  end
end
