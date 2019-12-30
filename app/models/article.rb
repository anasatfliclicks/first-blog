class Article < ApplicationRecord
	belongs_to :user
	has_one :photo, :as => :photoable
	has_many :comments, :as => :commentable
	has_many :article_categories
	has_many :categories, through: :article_categories
	validates :title, presence: true, length: {minimum: 3, maximum: 20}
	validates :description, presence: true, length: {minimum: 3, maximum: 50}
	validates :user_id, presence: true

end