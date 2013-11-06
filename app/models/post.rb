class Post < ActiveRecord::Base
	before_save :add_title

	def add_title
		self.alias = Transliteration.transliterate(self.title.mb_chars.downcase.to_s);
	end

	def to_param
    "#{id}-#{self.alias}".parameterize
  end
end
