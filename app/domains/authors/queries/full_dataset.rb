module Authors
  module Queries
    class FullDataset
      def call(id)
        column = if id.is_a?(Integer)
                   'id'
                 else
                   id.scan(/\D/).empty? ? 'id' : 'seo'
                 end

        ActiveRecord::Base.connection
                          .exec_query(sql(column, id))
                          .first
                          &.with_indifferent_access
      end

      def sql(column, value)
        <<-SQL
          SELECT
            authors.*,
            meta_data.title,
            meta_data.keywords,
            meta_data.description,
            text_blocks.text
          FROM authors
           LEFT JOIN meta_data ON meta_data.related = 0 AND meta_data.type = 'author'
           LEFT JOIN text_blocks ON text_blocks.related = 0 AND text_blocks.type = 'author'
           WHERE authors.#{column} = '#{value}'
        SQL
      end
    end
  end
end
