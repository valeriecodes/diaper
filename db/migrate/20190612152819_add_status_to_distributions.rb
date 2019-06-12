class AddStatusToDistributions < ActiveRecord::Migration[5.2]
  def change
    add_column :distributions, :status, :integer, default: 0
  end
end
