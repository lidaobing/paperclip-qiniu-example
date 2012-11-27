class QiniuImage
  cattr_accessor :host
  def self.default_options
    @default_options ||= {
      :sep => "-"
    }
  end


  module ActionView
    def qiniu_width(attachment, opts)
      old_height = attachment.height
      old_width = attachment.width
      return nil if old_height.nil? or old_width.nil?
      old_height += 0.0
      old_width += 0.0
      ratio = [opts[:width]/old_width, opts[:height]/old_height, 1.0].min
      (old_width*ratio).round
    end

    def qiniu_height(attachment, opts)
      old_height = attachment.height
      old_width = attachment.width
      return nil if old_height.nil? or old_width.nil?
      old_height += 0.0
      old_width += 0.0

      ratio = [opts[:width]/old_width, opts[:height]/old_height, 1.0].min
      (old_height*ratio).round
    end

    def qiniu_image(attachment, style, options={})
      opts = QiniuImage.default_options.merge(options)
      return options[:default_url] if options[:default_url] && !attachment.exists?
      if false
        attachment.url(:original, :timestamp => true)
      else
        url = attachment.url(:original, :timestamp => false)
        if url.start_with? '/'
          "#{QiniuImage.host}#{url}#{opts[:sep]}#{style}"
        else
          url
        end
      end
    end
  end
end

ActionView::Base.send :include, QiniuImage::ActionView

if Rails.env.production?
  QiniuImage.host = 'http://example-production.dn.qbox.me'
elsif Rails.env.staging?
  QiniuImage.host = 'http://example-staging.dn.qbox.me'
end
