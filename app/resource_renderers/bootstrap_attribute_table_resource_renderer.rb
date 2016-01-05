class BootstrapAttributeTableResourceRenderer < AttributeTableResourceRenderer
  private
  
  def table_html_options
    { class: 'table table-responsive table-condensed table-striped table-hover' }
  end
end
