require "rails_helper"

RSpec.describe Api::V2::MoviesController do
  let!(:genre) do
    create(:genre, name: "Action")
  end
  let!(:movie) do
    create(:movie, title: "Kill Bill", genre: genre)
  end
  let! (:movie_2) do
    create(:movie, title: "Inception", genre: genre)
  end

  let (:seriaized_movie) do
    {
        "id" => movie.id,
        "title" => movie.title,
        "genre_id" => movie.genre_id,
        "genre_name" => movie.genre.name,
        "movies_in_genre" => movie.genre.movies.count
    }
  end

  let (:seriaized_movie_2) do
    {
        "id" => movie_2.id,
        "title" => movie_2.title,
        "genre_id" => movie_2.genre_id,
        "genre_name" => movie_2.genre.name,
        "movies_in_genre" => movie_2.genre.movies.count
    }
  end

  describe "index action" do
    it "returns id and title of movies" do
      get :index

      parsed_response = JSON.parse(response.body)

      expect(parsed_response).to eq([seriaized_movie, seriaized_movie_2])
    end
  end

  describe "show action" do
    it "returns id and title of movie" do
      get :show, params: { id: movie.id }

      parsed_response = JSON.parse(response.body)

      expect(parsed_response).to eq(seriaized_movie)
    end
  end
end