require 'nokogiri'
require 'active_support/all'
require 'open-uri'
require_relative './post.rb'
require_relative './comment.rb'

def parse_scores(doc)
  doc.search('.score').map { |score| score.inner_text }
end

def extract_i_from_str(string)
  string.split(" ")[0].to_i
end

def parse_title(doc)
  title_arr = doc.search('title').map { |title| title.inner_text }
  title_arr.shift
end

def parse_post_url(doc)
  url_arr = doc.search('.title > a:first-child').map { |url| url['href'] }
  url_arr.shift
end

def parse_ids(doc)
  doc.search('.athing').map { |tr| tr['id'] }
end

def parse_users(doc)
  doc.search('.hnuser').map { |a| a.inner_text }
end

def parse_ages(doc)
  doc.search('.age > a:first-child').map { |a| a.inner_text }
end

def parse_comments(doc)
  content_arr = doc.search('.comment > span:first-child').map { |span| span.inner_text }
  content_arr.each.map { |comment| comment.gsub("\n", "").strip }
end

def date_from_str(str)
  int = extract_i_from_str(str)
  int.days.ago.to_date
end

def main

  doc = Nokogiri::HTML(open(ARGV[0]))
  points_arr = parse_scores(doc)
  id_arr = parse_ids(doc)
  user_arr = parse_users(doc)
  age_arr = parse_ages(doc)
  content_arr = parse_comments(doc)


  post = Post.new(parse_title(doc), parse_post_url(doc), extract_i_from_str(points_arr.shift), \
                    id_arr.shift, user_arr.shift, date_from_str(age_arr.shift))

  1.upto(content_arr.length) do
    post.add_comment(Comment.new(user_arr.shift, date_from_str(age_arr.shift), content_arr.shift, id_arr.shift))
  end

  post.to_s

end

main
