class AddRegionalCommitteeToPpsps < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :regional_committee, null: false, foreign_key: true
  end
end
