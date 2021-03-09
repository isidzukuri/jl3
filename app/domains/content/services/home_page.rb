module Content
  module Services
    class HomePage
      def call
        {
          articles: articles,
          text: text,
          metadata: metadata,
          last_books: last_books
        }
      end

      private

      def articles
        Article.select(:id, :seo_url, :title, :photo, :description, :img_alt, :img_title)
               .where(published: true)
               .order('id DESC')
               .limit(3)
      end

      def text
        TextBlock.where(type: 'home')
                 .select(:text)
                 .first
                 &.text
      end

      def metadata
        MetaData.where(type: 'home')
                .select(:title, :keywords, :description)
                .first
      end

      def last_books
        front_page_books = ActiveRecord::Base.connection
                                             .exec_query('SELECT * FROM front_page;')
                                             .first
                                             &.with_indifferent_access
        return unless front_page_books

        books_ids = front_page_books[:last].split(',')
        relation = Books::Queries::ListWithAuthors.new.call
        relation.where(id: books_ids).select(:cover)
      end
    end
  end
end
