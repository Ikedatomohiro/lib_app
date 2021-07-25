module ApplicationHelper
    # 遅延読み込みのためのヘルパー
    def lazysizes_image_tag(source, options={})
      if options[:class].blank?
          options[:class] = "lazyload"
          options['data-src'] = asset_path(source)
      elsif options[:class] == 'user_icon'
        if source.blank?
          source = "default_icon.svg"
        else
          source = "/downloads/images/user/user_icon_#{source}.jpg"
        end
        options['data-src'] = asset_path(source)
        options[:class] = "lazyload #{options[:class]}"
      else options[:class] == 'book_img shelf_book' || options[:class] == ' shelf_book'
        options[:class] = "lazyload #{options[:class]}"
        options['data-src'] = asset_path(source)
      end
      image_tag("", options) + ("<noscript>#{image_tag(source, options)}</noscript>").html_safe
    end

    # ユーザーのランダムIDがセットされていないとき用のイメージタグ
    def image_tag_if_null(source, options={})
      if source.blank?
        source = "default_icon.svg"
      else
        source = "/downloads/images/user/user_icon_#{source}.jpg"
      end
      options[:class] = "#{options[:class]}"
      image_tag(source, options)
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
