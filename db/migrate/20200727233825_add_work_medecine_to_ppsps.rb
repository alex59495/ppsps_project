class AddWorkMedecineToPpsps < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :work_medecine, null: false, foreign_key: true
  end
end
