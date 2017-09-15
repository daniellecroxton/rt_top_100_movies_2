class RtTop100MoviesCliApp::Movie

  attr_accessor :title, :movie_url, :tomatometer_score, :audience_score, :critic_consensus, :release_date, :rating, :genre, :director, :synopsis

  @@all = []

  def initialize(movies_hash)
    movies_hash.each do | attr, value |
      self.send("#{attr}=", value)
    end
    @@all << self
  end

  def add_details(details_hash)
    details_hash.each do | attr, value |
      self.send("#{attr}=", value)
    end
    self
  end

  def self.all
    @@all
  end

  def self.movies_release_after(year)
    released_movies = @@all.each.with_index do | movie, rank |
      if movie.title[-5..-2].to_i >= year
      puts "#{rank+1}. #{movie.title}"
      end
    end
    released_movies
  end

end
