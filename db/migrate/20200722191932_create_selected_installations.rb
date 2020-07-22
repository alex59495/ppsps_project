class CreateSelectedInstallations < ActiveRecord::Migration[6.0]
  def change
    create_table :selected_installations do |t|
      t.references :site_installation
      t.references :ppsp

      t.timestamps
    end
  end
end
