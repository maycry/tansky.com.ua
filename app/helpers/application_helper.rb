module ApplicationHelper
	def markdown(text)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true, :hard_wrap => true, :filter_html => true, :no_intraemphasis => true, :gh_blockcode => true)
		raw markdown.render(text)
	end

	def title(page_title)
		content_for :title, page_title.to_s + " • "
	end
end
