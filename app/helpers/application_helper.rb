module ApplicationHelper
	def canonical_url
    @page_seo_url || request.url
  end
end
