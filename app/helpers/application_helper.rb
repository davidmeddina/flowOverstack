# frozen_string_literal: true

module ApplicationHelper
  require 'redcarpet/render_strip'

  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div
    end
  end

  def markdown(text)
    coderayified = CodeRayify.new(filter_html: true, hard_wrap: true)
    options = {
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      autolink: true,
      lax_html_blocks: true
    }
    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    markdown_to_html.render(text).html_safe
  end

  def strip_markdown(text)
    markdown_to_plain_text = Redcarpet::Markdown.new(Redcarpet::Render::StripDown)
    markdown_to_plain_text.render(text).html_safe
  end

  def author(entry)
    user_signed_in? && current_user.id == entry.user_id
  end

  def username(email)
    email.split('@')[0]
  end

  def flash_msg(key)
    case key
      when 'notice' then 'alert alert-dismissible alert-info'
      when 'success' then 'alert alert-dismissible alert-success'
      when 'error' then 'alert alert-dismissible alert-danger'
      when 'alert' then 'alert alert-dismissible alert-warning'
    end
  end
end
