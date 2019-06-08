# frozen_string_literal: true

module ApplicationHelper
  def flash_msg(key)
    case key
      when 'notice' then 'alert alert-dismissible alert-info'
      when 'success' then 'alert alert-dismissible alert-success'
      when 'error' then 'alert alert-dismissible alert-danger'
      when 'alert' then 'alert alert-dismissible alert-warning'
    end
  end
end
