require 'nokogiri'

class Post

  attr_reader :title,:url,:points,:item_id,:user,:date

  def initialize(title, url, points, item_id, user, date)
    @title = title
    @url = url
    @points = points
    @item_id = item_id
    @user = user
    @date = date
    @comments = []
  end

  def comments
    @comments
  end

  def add_comment(comment)
    @comments << comment
  end

  def to_s
    puts "\nPost ID: #{item_id}"
    puts "Title: #{title} (#{url})"
    puts "Posted by #{user} on #{date}"
    puts "#{points} points"
    puts "#{comments.length} comments\n"
    puts "================================================\n\n"
    comments.each do |comment|
      comment.to_s
      print "\n\n"
    end
  end

end
