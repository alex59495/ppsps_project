class AddRepresentativeToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :representative, :string
  end
end
