module Pages
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
          SELECT
            page.*,
            meta_data.title,
            meta_data.keywords,
            meta_data.description,
            text_blocks.text
          FROM page
           LEFT JOIN meta_data ON page.id = meta_data.related AND meta_data.type = 'page'
           LEFT JOIN text_blocks ON page.id = text_blocks.related AND text_blocks.type = 'page'
           WHERE page.#{column} = '#{value}'
        SQL
      end
    end
  end
end
