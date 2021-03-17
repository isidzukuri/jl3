class FirstLettersController < ApplicationController
  def show
    @letter = Letter.find(params[:id])
    authors_scope = Author.select(:id, :full_name, :seo)
                          .where('l_name LIKE ?', "#{@letter.symbol}%")
                          .where(show: 1)
                          .order('l_name ASC')
    @authors = paginated_items(authors_scope)

    @text = TextBlock.where(type: 'letter')
                     .select(:text)
                     .first
                     &.text

    meta_data = MetaData.where(type: 'letter')
                        .select(:title, :keywords, :description)
                        .first
    @meta_title = "#{meta_data[:title]} #{@letter.symbol}"
    @meta_keywords = "#{meta_data[:keywords]} #{@letter.symbol}"
    @meta_description = "#{meta_data[:description]} #{@letter.symbol}"
  end
end
