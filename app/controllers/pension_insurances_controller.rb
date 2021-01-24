class PensionInsurancesController < DatabaseController
  def update
    @path = pension_insurances_path
    super
  end

  def destroyed
    @path = pension_insurances_path
    super
  end

  def init_infinite_loop
    @pagination_path = pagination_pension_insurances_path
    super
  end
end
