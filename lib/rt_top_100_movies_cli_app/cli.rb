class RtTop100MoviesCliApp::CLI

  def call
    puts ""
    puts "********* Best of Rotten Tomatoes: TOP 100 MOVIES OF ALL TIME *********"
    puts ""
    puts "Welcome cinephile! Which of Rotten Tomatoes' Top 100 Movies would you like to see?"
    create_movies
    start
  end

  def create_movies
    RtTop100MoviesCliApp::Scraper.scrape_top_100("https://www.rottentomatoes.com/top/bestofrt/")
  end

  def start
    puts ""
    puts "Please select from the following options:"
    puts "To see the top 100 movies, enter '1-25', '26-50', '51-75', or '76-100'"
    puts "To see all the movies on the list released after a given year (starting in 1920), enter the year"
    puts "To see the methodology behind the list, enter 'methodology'"
    puts "To exit the program, enter 'exit'"
    puts ""
    input = gets.strip.downcase

    display_movies(input)

    puts ""
    puts "To learn more about a specific movie, please enter the movie's rank. You can also enter 'main' to return to the main menu or 'exit' to exit the program."
    input = gets.strip.downcase


    if input.to_i.between?(1,100)
      selected_movie = RtTop100MoviesCliApp::Movie.all[input.to_i-1]
      add_movie_details(selected_movie)
      display_movie_details(selected_movie)
    elsif input == "main"
      start
    elsif input == "exit"
      exit
    else
      puts "I'm not quite sure what you meant."
      start
    end

    puts ""
    puts "Would you like to see more movies? Y/N"
    puts ""
    input = gets.strip.downcase
      if input == "y"
        start
      elsif input == "n"
        puts ""
        puts "The End. Thank you!"
        puts ""
        exit
      else
        puts ""
        puts "I'm not quite sure what you meant."
        puts ""
        start
      end
  end

  def display_movies(input)
      if input == "1-25" || input == "26-50" || input == "51-75" || input == "76-100"
        puts ""
        puts "********* Best of Rotten Tomatoes: TOP MOVIES OF ALL TIME #{input} *********"
        puts ""
        list_from = input.to_i
        RtTop100MoviesCliApp::Movie.all[list_from-1, 25].each.with_index(list_from) do | movie, rank |
          puts "#{rank}. #{movie.title}"
        end
      elsif input.to_i.between?(1920, Date.today.year)
        puts ""
        puts "********* Best of Rotten Tomatoes: TOP MOVIES RELEASED IN OR AFTER #{input} *********"
        puts ""
        year = input.to_i
        RtTop100MoviesCliApp::Movie.movies_release_after(year)
      elsif input == "methodology"
        puts ""
        puts "Methodology: Each critic from Rotten Tomatoes' discrete list gets one vote, weighted equally. A movie must have 40 or more rated reviews to be considered. The 'Adjusted Score' comes from a weighted formula (Bayesian) that we use that accounts for variation in the number of reviews per movie."
        puts ""
        start
      elsif input == "exit"
        puts ""
        puts "The End. Thank you!"
        puts ""
        exit
      else
        puts "I'm not quite sure what you meant."
        start
    end
  end

  def add_movie_details(selected_movie)
      details_hash = RtTop100MoviesCliApp::Scraper.scrape_movie("https://www.rottentomatoes.com#{selected_movie.movie_url}")
      selected_movie.add_details(details_hash)
  end

  def display_movie_details(selected_movie)
      puts ""
      puts "********* Best of Rotten Tomatoes: #{selected_movie.title} *********"
      puts ""
      puts "Title:  #{selected_movie.title}"
      puts ""
      puts "Tomatometer Score: #{selected_movie.tomatometer_score}"
      puts "Audience Score: #{selected_movie.audience_score}"
      puts "Critic Consensus: #{selected_movie.critic_consensus}"
      puts ""
      puts "Rated: #{selected_movie.rating}"
      puts "Genre: #{selected_movie.genre}"
      puts "Released: #{selected_movie.release_date}"
      puts "Directed by: #{selected_movie.director}"
      puts ""
      puts "Synopsis: #{selected_movie.synopsis}"
      puts ""
  end

end
