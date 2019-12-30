class ArticlesDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Article.count,
      iTotalDisplayRecords: articles.total_entries,
      aaData: data
    }
  end

private

  def data
    articles.map do |article|
      [
        link_to(article.title, article),
        h(article.category),
        # h(product.released_on.strftime("%B %e, %Y")),
        # number_to_currency(product.price)
      ]
    end
  end

  def articles
    @articles ||= fetch_articles
  end

  def fetch_articles
    articles = Article.order("#{sort_column} #{sort_direction}")
    articles = articles.page(page).per_page(per_page)
    if params[:sSearch].present?
      articles = articles.where("title like :search or category like :search", search: "%#{params[:sSearch]}%")
    end
    articles
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name category released_on price]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end