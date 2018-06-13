require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper


  def get_page
    html = open('http://learn-co-curriculum.github.io/site-for-scraping/courses')
    Nokogiri::HTML(html)
  end

  def get_courses
    #.post-holder , h2
    # get_page.css(".post-holder .post")
    get_page.css(".posts-holder .post")

  end

  def make_courses
    get_courses.each do |course|
      t = course.css("h2").text
      s = course.css(".date").text
      d = course.css("p").text

      course = Course.new
      course.title = t
      course.schedule = s
      course.description = d

    end
  end

    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

end
