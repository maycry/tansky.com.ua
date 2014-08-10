class Post < ActiveRecord::Base
	before_save :add_title
	after_save  :transfer_images, :update_image_links
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

  def transfer_images
  	s3 = AWS::S3.new
  	bucket = s3.buckets["blog.tansky.com.ua"]
  	temp_images = bucket.objects["temp"]
  	post_images = bucket.objects["#{id}/"]
  	bucket.objects.with_prefix('temp').each do |object|
  	   object.move_to("#{id}/#{object.key.gsub("temp/", "")}", {:acl => :public_read})
  	end
  	temp_images.delete
  end

  def update_image_links
  	update_column("body", self.body.gsub("/temp/", "/#{id}/"))
  end
end
