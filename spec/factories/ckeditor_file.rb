Factory.define :ckeditor_file, :class => Ckeditor::AttachmentFile do |c|
	c.data File.new("#{Rails.root}/spec/data/file.pdf")
end