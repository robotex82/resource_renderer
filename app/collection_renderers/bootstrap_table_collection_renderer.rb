class BootstrapTableCollectionRenderer < TableCollectionRenderer
  private

  def renderer_class_name
    'TableResourceRenderer'
  end

  def table_html_options
    @table_html_options || { class: 'table table-responsive table-condensed table-striped table-hover' }
  end
end
