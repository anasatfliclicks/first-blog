class ArticleDatatable < AjaxDatatablesRails::ActiveRecord
   def_delegators :@view, :check_box_tag, :link_to, :mail_to, :edit_user_path

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
      title:         { source: "Article.title" },
      description: { source: "Article.description", cond: :like, searchable: true, orderable: true },
      categories:  { source: "Article.categories",  cond: :like , formatter: -> (o) { o.upcase } },
    }
  end
  def initialize(params, opts = {})
      @view = opts[:view_context]
      super
  end
  def data
    records.map do |record|
      {
        # example:
        # id: record.id,
        # name: record.name
        title:         record.title,
        description: record.description,
        categories:  record.categories,
        DT_RowId:   record.id, # This will automagically set the id attribute on the corresponding <tr> in the datatable
      }
    end
  end

  def get_raw_records
    # insert query here
    # User.all
    Article.all
  end

end
