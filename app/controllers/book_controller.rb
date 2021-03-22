class BookController < ApplicationController
  def latest
    @books = Books::Queries::ListWithAuthors.new
                                            .call
                                            .limit(150)
                                            .reorder('id DESC')

    @text = TextBlock.where(type: 'latest_incomes')
                     .select(:text)
                     .first
                     &.text

    meta_data = MetaData.where(type: 'latest_incomes')
                        .select(:title, :keywords, :description)
                        .first

    @meta_title = meta_data[:title]
    @meta_keywords = meta_data[:keywords]
    @meta_description = meta_data[:description]
  end

  private
end
