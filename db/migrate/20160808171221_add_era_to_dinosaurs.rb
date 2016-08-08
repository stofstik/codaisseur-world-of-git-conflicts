class AddEraToDinosaurs < ActiveRecord::Migration[5.0]
  def change
    add_column :dinosaurs, :era, :string
  end
end
