module ApplicationHelper
    # 遅延読み込みのためのヘルパー
    def lazysizes_image_tag(source, options={})
      options['data-src'] = asset_path(source)
      if options[:class].blank?
        options[:class] = "lazyload"
      else
        options[:class] = "lazyload #{options[:class]}"
      end
       image_tag("", options) + ("<noscript>#{image_tag(source, options)}</noscript>").html_safe
    end
end
