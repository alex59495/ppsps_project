class AddWebsiteToPensionInsurances < ActiveRecord::Migration[6.0]
  def change
    add_column :pension_insurances, :website, :string
    add_column :direccts, :website, :string
    add_column :regional_committees, :website, :string
  end
end
