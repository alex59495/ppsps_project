class CreateSiteInstallations < ActiveRecord::Migration[6.0]
  def change
    create_table :site_installations do |t|
      t.string :name
      t.boolean :mobile

      t.timestamps
    end
  end
end
