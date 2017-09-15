require 'pry'
require 'open-uri'

class RtTop100MoviesCliApp::Scraper

  def self.scrape_top_100(main_url)
      top_100_page = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/"))

      top_100_page.css("div.panel-body.content_body.allow-overflow table.table").each do | box |
        box.css('a.unstyled.articleLink').each do |movie|
          movie_title = movie.text.strip
          movie_url = movie.attr('href')
          RtTop100MoviesCliApp::Movie.new({title: movie_title, movie_url: movie_url})
        end
      end
    end

  def self.scrape_movie(details_url)
    movie_details = {}
    details_page = Nokogiri::HTML(open(details_url))

    details_page.css('#mainColumn').each do | detail |
      movie_details[:tomatometer_score] = detail.css("#scorePanel .tab-content #all-critics-numbers a .meter-value").text
      movie_details[:audience_score] = detail.css(".audience-score a .superPageFontColor").first.text
      movie_details[:critic_consensus] = detail.css(".critic_consensus.tomato-info.noSpacing.superPageFontColor").text.gsub("Critic Consensus:", "").split.join(" ")
      movie_details[:synopsis] = detail.css("#movieSynopsis").text.strip
      movie_details[:rating] = detail.css("div.panel-body ul.content-meta li .meta-value").first.text.strip
      movie_details[:release_date] = detail.css("div.panel-body ul.content-meta li .meta-value")[4].text.strip.split.join(" ")
      movie_details[:genre] = detail.css("div.panel-body ul.content-meta li .meta-value")[1].text.strip.split.join(" ")
      movie_details[:director] = detail.css("div.panel-body ul.content-meta li .meta-value")[2].text.strip
    end

    movie_details
  end

end
