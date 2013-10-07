require 'rubygems'

module Jekyll
  class FileLinkTag < Liquid::Tag

    def initialize(tag_name, text, token)
      super
      @text = text.strip
      puts @text
      @text =~ /(\w+\.\w+)(\shref:)?(\w+\.\w+)/i
      puts @text
      puts $1
      puts $3
      @file_link_name = $1
      @file_link_href = $3
    end

    def render(context)
      if @file_link_name
        "<a href='/other_files/#{@file_link_href}'>#{@file_link_name}</a>"
      else
        "Error processing input."
      end
    end
  end
end

Liquid::Template.register_tag('filelink', Jekyll::FileLinkTag)
