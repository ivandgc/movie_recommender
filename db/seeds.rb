
pages = 40
movies = []

(1...39).to_a.each do |x|
	movies.concat(JSON.parse(RestClient.get("https://api.themoviedb.org/3/discover/movie?api_key=de37d8ef6879dae3df30b07a16be01e7&page=" + x.to_s))["results"])
end

movies.each do |movie|
	genres = "/" + movie["genre_ids"].join("/") + "/"
	Movie.create(title: movie["title"],
				 poster_path: movie["poster_path"],
				 overview: movie["overview"],
				 release_date: movie["release_date"],
				 genre: genres)
end

