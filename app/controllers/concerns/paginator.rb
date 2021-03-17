module Paginator
  include Pagy::Backend

  HTML_CLASS = 'class="flink"'

  def paginated_items(scope, limit: 100)
    @paginator, items = pagy(scope, items: limit, link_extra: HTML_CLASS)

    items
  end
end
