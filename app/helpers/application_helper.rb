module ApplicationHelper

  def history_path(i)
    if session[:page_history]
      session[:page_history][i] || root_path
    else
      root_path
    end
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def app_logo
    if !Rails.cache.read("logo") || params['exc'] == "true"
      site_logo = Rails.cache.read("uapp_data")['site_logo']
      if site_logo.to_s != ''
        if !site_logo.to_s.match(/^</) # if not SVG path
          site_logo = image_tag(site_logo)
        end
        site_logo = site_logo + '<span>&nbsp; </span>'
      end
      if Preference.app_logo.to_s != ''
        if Preference.app_logo.to_s.match(/^</)  # if SVG path
          logo = (site_logo + Preference.app_logo.to_s).html_safe
        else
          logo = (site_logo + image_tag(Preference.app_logo)).html_safe
        end
      else
        logo = (site_logo + Setting.app_name).html_safe
      end
      Rails.cache.write("logo", logo, :expires_in => 1.days)
    end
    Rails.cache.read("logo")
  end

  def site_announcement
    Rails.cache.read("uapp_data")['site_announcement'] && markdown_format(Rails.cache.read("uapp_data")['site_announcement']).gsub(/\<\/?p\>/, '').html_safe
  end

  def apps_navigation
    Rails.cache.read("uapp_data")['site_navigation']
  end

  def apps_menu
    Rails.cache.read("uapp_data")['site_menu']
  end

  def page_footer
    Rails.cache.read("uapp_data")['page_footer'] && Rails.cache.read("uapp_data")['page_footer'].html_safe
  end

  def default_authorize_path
    user_omniauth_authorize_path(:uapp)
  end

  def markdown_format(s)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }
    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    markdown.render(s).html_safe
  end

  def regexp_parse(s)
    s.gsub('$', '').gsub('.+', '').gsub('\.', '.')
  end

  def fb_image_tag(id, size=100)
    image_tag 'https://graph.facebook.com/' + id.to_s + '/picture?width=' + size.to_s + '&height=' + size.to_s
  end

  def options_for_select_to_item_menu(s)
    s.gsub(/option/, 'div').gsub(/value/, 'class="item" data-value').html_safe
  end
end
