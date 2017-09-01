require 'pry'

class RtTop100MoviesCliApp::Scraper

  def self.scrape_top_100(main_url)
      top_100_page = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/"))
      movies = []
      top_100_page.css("div.panel-body.content_body.allow-overflow table.table").each do | box |
        box.css('a.unstyled.articleLink').each do |movie|
          movie_title = movie.text
          movie_url = movie.attr('href')
          movies << {title: movie_title, movie_url: movie_url}
        end
      end
      movies
    end

  def self.scrape_movie(details_url)
    movie_details = {}
    details_page = Nokogiri::HTML(open(details_url))
    details_page.css('#mainColumn').each do | detail |
      # binding.pry

      movie_details[:tomatometer_score] = detail.css("#scorePanel .tab-content #all-critics-numbers a .meter-value").text
      movie_details[:audience_score] = detail.css(".audience-score a .superPageFontColor").first.text
      movie_details[:critic_consensus] = detail.css(".critic_consensus.tomato-info.noSpacing.superPageFontColor").text.strip #needs regex to remove Critic Consensus:\n
      movie_details[:synopsis] = detail.css('#movieSynopsis').text.strip
    end

    details_page.css('#mainColumn').each do | detail |
      if detail.css('.media-body .meta-label').text.include?("In Theaters:")
        movie_details[:release_date] = detail.css('.media-body .meta-value').text.strip
      elsif detail.css('.media-body .meta-label').text.include?("Rating:")
        movie_details[:rating] = detail.css('.media-body .meta-value').text.strip
      elsif detail.css('.media-body .meta-label').text.include?("Genre:")
        movie_details[:genre] = detail.css('.media-body .meta-value').text.strip
      elsif detail.css('.media-body .meta-label').text.include?("Directed By:")
        movie_details[:director] = detail.css('.media-body .meta-value').text.strip
      end
    end

    movie_details
  end

end
