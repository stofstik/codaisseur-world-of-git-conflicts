class AddSoundToDinosaurs < ActiveRecord::Migration[5.0]
  def change
    add_column :dinosaurs, :sound, :string
  end
end
