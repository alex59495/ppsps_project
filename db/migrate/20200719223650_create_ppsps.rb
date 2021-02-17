class CreatePpsps < ActiveRecord::Migration[6.0]
  def change
    create_table :ppsps do |t|
      t.string :agglomeration
      t.string :street_impact
      t.string :river_guidance
      t.timestamps
    end
  end
end
