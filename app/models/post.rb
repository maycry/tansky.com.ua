class Post < ActiveRecord::Base
	before_save :add_title
	acts_as_taggable

	default_scope { order("created_at desc") }

	def image
		
	end

	def image_attributes=(attributes)
		
	end

	def add_title
		self.alias = Transliteration.transliterate(self.title.mb_chars.downcase.to_s);
	end

	def to_param
    "#{id}-#{self.alias}".parameterize
  end
end
