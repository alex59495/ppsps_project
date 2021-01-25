class RegionalCommitteesController < DatabaseController
  def update
    @path = regional_committees_path
    super
  end

  def destroyed
    @path = regional_committees_path
    super
  end

  def init_infinite_scroll
    @pagination_path = pagination_regional_committees_path
    super
  end
end
