class TimelineCollectionRenderer < ResourceRenderer::CollectionRenderer::Base
  def collection
    @collection.sort! { |a, b| a.happened_at <=> b.happened_at }
  end
end
