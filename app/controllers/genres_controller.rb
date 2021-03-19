class GenresController < ApplicationController
  def show
    @genre_data = Genres::Queries::FullDataset.new.call(params[:id])

    books_scope = Books::Queries::ListWithAuthors.new
                                                 .call
                                                 .where(genre: @genre_data[:id])
    @books = paginated_items(books_scope)

    @text = @genre_data[:text] || I18n.t(:default_text)
    meta_data
  end

  private

  def meta_data
    %i[title keywords description].each do |field|
      value = if @genre_data[field]
                "#{@genre_data[field]} #{params[:page]}"
              else
                "#{I18n.t("default_#{field}")} #{I18n.t(:page)} #{params[:page]}"
              end
      instance_variable_set("@meta_#{field}", value)
    end
  end
end
