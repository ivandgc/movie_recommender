
pages = 40
movies = []

(81...120).to_a.each do |x|
	movies.concat(JSON.parse(RestClient.get("https://api.themoviedb.org/3/discover/movie?api_key=de37d8ef6879dae3df30b07a16be01e7&page=" + x.to_s))["results"])
end


movies.each do |movie|

	begin
		rating = Nokogiri::HTML(RestClient.get("https://www.rottentomatoes.com/m/#{movie['title'].gsub(/[^0-9a-z \-]/i,"").gsub(/[\s\-]/,"_")}")).css('div.critic-score.meter span.meter-value').children[0].children.text
	rescue RestClient::NotFound, URI::InvalidURIError => e
		release_year = movie["release_date"].split("-")[0]
		begin
			rating = Nokogiri::HTML(RestClient.get("https://www.rottentomatoes.com/m/#{movie['title'].gsub(/[^0-9a-z \-]/i,"").gsub(/[\s\-]/,"_")}_#{release_year}")).css('div.critic-score.meter span.meter-value').children[0].children.text
		rescue RestClient::NotFound, URI::InvalidURIError => e
			rating = "N/A"
		rescue NoMethodError => e
			rating = Nokogiri::HTML(RestClient.get("https://www.rottentomatoes.com/m/#{movie['title'].gsub(/[^0-9a-z \-]/i,"").gsub(/[\s\-]/,"_")}_#{release_year}")).css('div.meter-value').children.children.text.gsub(/%/,"")
		end

	rescue NoMethodError => e
		rating = Nokogiri::HTML(RestClient.get("https://www.rottentomatoes.com/m/#{movie['title'].gsub(/[^0-9a-z \-]/i,"").gsub(/[\s\-]/,"_")}")).css('div.meter-value').children.children.text.gsub(/%/,"")
	end



	genres = movie["genre_ids"].join("/")
	Movie.create(title: movie["title"],
				 poster_path: movie["poster_path"],
				 overview: movie["overview"],
				 release_date: movie["release_date"],
				 genre: genres,
				 rating: rating)
end

