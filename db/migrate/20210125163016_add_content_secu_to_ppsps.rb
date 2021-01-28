class AddContentSecuToPpsps < ActiveRecord::Migration[6.0]
  def change
    add_column :ppsps, :content_secu, :text, default: ''
  end
end
