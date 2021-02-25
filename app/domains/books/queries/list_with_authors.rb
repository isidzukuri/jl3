module Books
  module Queries
    class ListWithAuthors
      def call
        Book.joins(:author)
            .order('bookname ASC')
            .select('book.id,
                     book.bookname,
                     book.txt_size_kb,
                     book.seo,
                     book.authorid,
                     authors.f_name,
                     authors.l_name,
                     authors.seo as author_seo')
      end
    end
  end
end
