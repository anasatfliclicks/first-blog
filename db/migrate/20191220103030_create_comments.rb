class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
    	t.string :comment
    	t.integer :commentable_id
    	t.string :commentable_type
    end
  end
end
