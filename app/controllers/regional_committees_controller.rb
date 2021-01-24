class RegionalCommitteesController < DatabaseController
  def update
    @path = regional_committees_path
    super
  end

  def destroyed
    @path = regional_committees_path
    super
  end

  def init_infinite_loop
    @pagination_path = pagination_regional_committees_path
    super
  end
end
