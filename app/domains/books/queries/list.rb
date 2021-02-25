module Books
  module Queries
    class List
      def call
        Book.order('bookname ASC')
            .select('book.id,
                     book.bookname,
                     book.txt_size_kb,
                     book.seo')
      end
    end
  end
end
