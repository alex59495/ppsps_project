class AddContentSecuToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :content_secu, :text
  end
end
