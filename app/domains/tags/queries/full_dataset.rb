module Tags
  module Queries
    class FullDataset
      def call(id)
        column = if id.is_a?(Integer)
                   'id'
                 else
                   id.scan(/\D/).empty? ? 'id' : 'seo_url'
                 end

        ActiveRecord::Base.connection
                          .exec_query(sql(column, id))
                          .first
                          &.with_indifferent_access
      end

      def sql(column, value)
        <<-SQL
          SELECT
            tags.*,
            meta_data.title AS meta_title,
            meta_data.keywords,
            meta_data.description,
            text_blocks.text
          FROM tags
           LEFT JOIN meta_data ON meta_data.related = 0 AND meta_data.type = 'tags'
           LEFT JOIN text_blocks ON text_blocks.related = 0 AND text_blocks.type = 'tags'
           WHERE tags.#{column} = '#{value}'
        SQL
      end
    end
  end
end
