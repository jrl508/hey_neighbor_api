class AddAvailabilityToTools < ActiveRecord::Migration[7.1]
  def change
    add_column :tools, :availability, :boolean
  end
end
