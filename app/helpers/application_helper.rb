module ApplicationHelper

  def link_to_with_icon(body, url, html_options={})
    icon = html_options.delete(:icon)
    body = "<i class=\"#{icon}\"></i><span>#{body}</span>"
    link_to(body.html_safe, url, html_options).html_safe
  end

  def ilink_to(body, url, html_options={})
    html_options[:icon] = 'i-' + body.downcase
    link_to_with_icon(body, url, html_options)
  end

  def btn_link_to(body, url, html_options={})
    html_options[:class] = 'btn ' + 'btn-' + body.downcase
    link_to_with_icon(body, url, html_options)
  end

  def ibtn_link_to(body, url, html_options={})
    html_options[:icon] = 'i-' + body.downcase
    html_options[:class] = 'btn ' + 'btn-' + body.downcase
    link_to_with_icon(body, url, html_options)
  end

  def ibtn_link_to_save(url)
    url = "javascript:submitForm('#{url}')"
    html_options = {}
    html_options[:icon] = 'i-save'
    html_options[:class] = 'btn-green'
    link_to_with_icon('save', url, html_options)
  end

  def ilink_to_destroy(url)
    html_options = {}
    html_options[:icon] = 'i-destroy'
    html_options[:'data-confirm'] = 'Are you sure?'
    html_options[:'data-method'] = 'delete'
    link_to_with_icon('Delete', url, html_options)
  end

end