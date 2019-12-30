class Category < ApplicationRecord
	before_save { self.name = name.capitalize }

	has_one :photo, :as => :photoable
	has_many :comments, :as => :commentable
	has_many :article_categories
	has_many :articles, through: :article_categories
	validates :name, presence: true, length: { minimum: 3, maximum: 15}, uniqueness: { case_sensitive: false}
end