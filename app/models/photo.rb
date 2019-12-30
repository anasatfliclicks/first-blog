class Photo < ApplicationRecord
	belongs_to :photoable, :polymorphic => true
	has_one_attached :image
	validates :image, presence: true
end