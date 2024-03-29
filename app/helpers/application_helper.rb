#!/bin/env ruby
# encoding: utf-8

module ApplicationHelper
  
  # Creates a base title and attaches the provided title if indeed it is provided
  def full_title(page_title)
    base_title = "Offtrafik"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
end
