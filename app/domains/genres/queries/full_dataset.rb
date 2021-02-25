module Genres
  module Queries
    class FullDataset
      def call(id)
        column = if id.is_a?(Integer)
                   'id'
                 else
                   id.scan(/\D/).empty? ? 'id' : 'seo_name'
                 end

        ActiveRecord::Base.connection
                          .exec_query(sql(column, id))
                          .first
                          &.with_indifferent_access
      end

      def sql(column, value)
        <<-SQL
          SELECT#{' '}
            genre.id,
            genre.name,
            meta_data.title,
            meta_data.keywords,
            meta_data.description,#{' '}
            text_blocks.text
          FROM genre
           LEFT JOIN meta_data ON genre.id = meta_data.related AND meta_data.type = 'genre'
           LEFT JOIN text_blocks ON genre.id = text_blocks.related AND text_blocks.type = 'genre'
           WHERE genre.#{column} = '#{value}'
        SQL
      end
    end
  end
end
