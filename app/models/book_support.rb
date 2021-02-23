class BookSupport < ApplicationRecord
  self.table_name = 'book_support'

  belongs_to :book, foreign_key: :id
end
