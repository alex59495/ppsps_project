class AddInfirmaryToWorksite < ActiveRecord::Migration[6.0]
  def change
    add_column :worksites, :infirmary, :boolean, default: false
    add_column :worksites, :infirmary_text, :text
  end
end
