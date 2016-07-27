require 'nokogiri'

class Comment

  attr_reader :user, :date, :content, :id

  def initialize(user,date,content,id)
    @user = user
    @date = date
    @content = content
    @id = id
  end

  def to_s
    puts "Username: #{user}"
    puts "Date: #{date}"
    puts "-----"
    puts "#{content}"
  end

end
