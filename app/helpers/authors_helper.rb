module AuthorsHelper
  def author_path_param(author)
    author[:seo].presence || author[:id]
  end
end
