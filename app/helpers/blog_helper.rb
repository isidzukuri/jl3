module BlogHelper
  def article_image_src(article)
    "/uploads/blog/300x300_#{article[:photo]}"
  end
end
