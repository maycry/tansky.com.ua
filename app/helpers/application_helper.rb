module ApplicationHelper
	def markdown(text)
		options = {autolink: :true, space_after_headers: :true, hard_wrap: :true, filter_html: :true, no_intraemphasis: :true, gh_blockcode: :true}
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
		addImageTitles(markdown.render(text))
	end

	def addImageTitles(html)
		doc = Nokogiri::HTML(html)
		doc.css("img").wrap("<figure></figure>").each do |img|
			img.after("<figcaption>#{img[:alt]}</figcaption>") if img[:alt]
			img.parent.parent.replace img.parent.parent.inner_html
		end
		raw doc
	end

	def title(page_title)
		content_for :title, page_title.to_s + " • "
	end
end
