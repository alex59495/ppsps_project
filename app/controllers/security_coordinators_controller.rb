class SecurityCoordinatorsController < DatabaseController
  def update
    @path = security_coordinators_path
    super
  end

  def destroyed
    @path = security_coordinators_path
    super
  end

  def init_infinite_loop
    @pagination_path = pagination_security_coordinators_path
    super
  end
end
