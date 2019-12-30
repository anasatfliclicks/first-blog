class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
    	t.integer :photoable_id
    	t.string :photoable_type
    end
  end
end
