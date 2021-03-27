class AuthorsController < ApplicationController
  def show
    page_data

    @meta_title = "#{@author_data[:full_name]} #{@author_data[:title]}"
    @meta_keywords = "#{@author_data[:full_name]} #{@author_data[:keywords]}"
    @meta_description = "#{@author_data[:full_name]} #{@author_data[:description]}"
    @text = @author_data[:text]
  end

  def bio
    page_data
    
    @meta_title = "#{@author_data[:full_name]} #{I18n.t(:biography)} #{@author_data[:title]}"
    @meta_keywords = "#{@author_data[:full_name]} #{I18n.t(:biography)} #{@author_data[:keywords]}"
    @meta_description = "#{@author_data[:full_name]} #{I18n.t(:biography)} #{@author_data[:description]}"
  end

  private

  def page_data
    @author_data = Authors::Queries::FullDataset.new.call(params[:id])

    books_scope = Books::Queries::List.new
                                      .call
                                      .where(author: @author_data[:id])
    @books = paginated_items(books_scope)
  end
end
