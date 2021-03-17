class BlogController < ApplicationController
  include BlogHelper

  def index
    articles_scope = Article.select(:id, :seo_url, :title, :photo, :description, :img_alt, :img_title)
                            .where(published: true)
                            .order('id DESC')
    @articles = paginated_items(articles_scope, limit: 10)

    meta_data = MetaData.where(type: 'blog')
                        .select(:title, :keywords, :description)
                        .first
    @meta_title = meta_data[:title]
    @meta_keywords = meta_data[:keywords]
    @meta_description = meta_data[:description]
  end

  def show
    @article = Article.find_by_seo_url!(params[:id])
    @meta_title = @article[:title]
    @meta_keywords = @article[:keywords]
    @meta_description = @article[:meta_description]
    @share_fb_images = [article_image_src(@article)]
    @other_articles = Article.select(:id, :seo_url, :title, :photo, :img_alt, :img_title)
                             .where(published: true)
                             .where.not(id: @article.id)
                             .order('RAND()')
                             .limit(3)
  end
end
