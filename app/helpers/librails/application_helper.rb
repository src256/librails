# coding: utf-8
module Librails
  module ApplicationHelper
    def bootstrap_class_for(flash_type)
      { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
    end

    # noinspection RubyUnusedLocalVariable
    def flash_messages(opts = {})
      # https://github.com/plataformatec/devise/issues/1777
      # deviseが:timeoutにtrueをぶちこんでくるのでそれを除外する
      flash.each do |msg_type, message|
        next if msg_type == :timedout
        concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible", role: 'alert') do
                 concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
                          concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
                          concat content_tag(:span, 'Close', class: 'sr-only')
                        end)
                 concat message
               end)
      end
      nil
    end

    def ransack_value(params, value_para, query_param = 'q')
      q = params[query_param]
      return nil unless q
      return nil unless q.kind_of?(Hash)
      q[value_param]
    end
  end
end
