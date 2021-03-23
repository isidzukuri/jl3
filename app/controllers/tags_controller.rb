class TagsController < ApplicationController
  def index
    tags_scope = Tag.where(visible: 1)
                    .order('title ASC')

    @tags = paginated_items(tags_scope)

    @meta_title = I18n.t(:title_tag_list)
    @meta_keywords = I18n.t(:keywords_tag_list)
    @meta_description = I18n.t(:description_tag_list)
  end

  def show
    @tag_data = Tags::Queries::FullDataset.new.call(params[:id])

    books_scope = Books::Queries::ListWithAuthors.new
                                                 .call
                                                 .joins(:book_tags)
                                                 .where(book_tags: { tag_id: @tag_data[:id] })
    @books = paginated_items(books_scope)

    @meta_title = "#{@tag_data[:title]}. #{@tag_data[:meta_title]} #{params[:page]}"
    @meta_keywords = "#{@tag_data[:title]} #{@tag_data[:keywords]}"
    @meta_description = "#{@tag_data[:title]}. #{@tag_data[:description]} #{params[:page]}"
  end
end
