# encoding: UTF-8

# Class encapsulating the bits and pieces of a single post
class BlogEntry

  attr_accessor :title, :content, :author, :blogger_name, :tags, :slug, :date, :lace, :relative_url,:disqus_thread_id

  def to_erb
  	# quotes in title must be escaped, also backslash with double backslash
    escaped_title = @title.gsub(/\\/, '\&\&').gsub(/\"/, '\"')

  	# prepare comma separated list of tags
    tag_string = ""
    tags.each { |tag| tag_string = tag_string + tag + "," }
    tag_string = tag_string.gsub(/,$/, '')

    erb = "---\n" <<
    "title: \"#{escaped_title}\"\n" <<
    "author: \"#{@author}\"\n" <<
    "blogger_name: \"#{@blogger_name}\"\n" <<
    "creation_date: \"#{@date.strftime( "%d-%m-%Y" )}\"\n" <<
    "tags: [#{tag_string}]\n" <<
    "\n" <<
    "relative_url: #{@relative_url}\n" <<
    "slug: #{@slug}\n" <<
    "lace: #{@lace}\n" <<
    "\n" <<
    "layout: blog-post\n" <<
    "\n" <<
    "disqus_thread_id: #{@disqus_thread_id}\n" <<
    "---\n" <<
    "#{content}\n"
  end

  def file_name
  	date_string = date.strftime( "%Y-%m-%d" )
  	return File.join( @blogger_name, "#{date_string}-#{slug}.html.erb" )
  end
end
