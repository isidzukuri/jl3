module Books
  module Queries
    class FullDataset

      def call(id)
        column = if id.is_a?(Integer)
                   'id'
                 else
                   id.scan(/\D/).empty? ? 'id' : 'seo'
                 end

        result = ActiveRecord::Base.connection
                                   .exec_query(sql(column, id))
                                   .first
                                   .with_indifferent_access

        result[:id] ? result : nil
      end

      def sql(column, value)
        <<-SQL
          SELECT book.*, 
            authors.f_name, 
            authors.l_name, 
            authors.seo AS author_seo, 
            genre.name, 
            genre.seo_name, 
            book_support.censorship, 
            book_support.shop_url, 
            book_support.author_link, 
            book_support.shop_msg, 
            book_support.bad_txt, 
            book_support.bad_doc, 
            book_support.bad_fb2, 
            book_support.bad_epub, 
            book_support.bad_jar,
            meta_data.title as meta_title,
            meta_data.keywords as meta_keywords,
            meta_data.description as meta_description, 
            text_blocks.text as text_block, 
            avg(rate) AS rating, 
            COUNT(book_ratings.book_id) AS ratings_count
          FROM book
           INNER JOIN authors ON authors.id = book.authorid
           INNER JOIN genre ON genre.id = book.genre
           INNER JOIN book_support ON book_support.id = book.id
           LEFT JOIN meta_data ON meta_data.related = '0' AND meta_data.type = 'book'
           LEFT JOIN text_blocks ON text_blocks.related = '0' AND text_blocks.type = 'book'
           LEFT JOIN book_ratings ON book_ratings.book_id = book.id  
           WHERE book.#{column} = '#{value}'
        SQL
      end
    end
  end
end