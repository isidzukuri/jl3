class Book < ApplicationRecord
  self.table_name = 'book'

  FORMATS = %w[txt jar fb2 epub doc]

  has_one :book_support, foreign_key: :id
  has_many :book_tags
  has_many :tags, through: :book_tags
  has_many :book_ratings
  belongs_to :author, foreign_key: :authorid
  belongs_to :genre, foreign_key: :genre
end
