Factory.define :ckeditor_image, :class => Ckeditor::Picture do |c|
	c.data File.new("#{Rails.root}/spec/data/image.jpg")
end