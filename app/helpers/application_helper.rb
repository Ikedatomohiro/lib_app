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

    # フッターアイコンの色制御
    def set_home_flg
        @home_flg = true
    end

    def set_bookshelf_flg
        @bookshelf_flg = true
    end

    def set_setting_flg
        @setting_flg = true
    end

    def set_analysis_flg
        @analysis_flg = true
    end
end
