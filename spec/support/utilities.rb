#!/bin/env ruby
# encoding: utf-8

def full_title(page_title)
  base_title = "Koç Carpool Projesi"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end