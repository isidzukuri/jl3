module Books
  module Services
    class FullDataset
      def call(book_id)
        data = Queries::FullDataset.new.call(book_id)
        return unless data

        data[:tags_list] = tags_list(data[:id])
        data
      end

      private

      def tags_list(book_id)
        Tag.joins(:book_tags).where(book_tags: { book_id: book_id, moderated: true }, visible: true)
      end
    end
  end
end
