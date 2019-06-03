require "rails_helper"

RSpec.describe Api::V1::MoviesController do
  let!(:movie) do
    create(:movie, title: "Kill Bill")
  end
  let! (:movie_2) do
    create(:movie, title: "Inception")
  end

  let (:seriaized_movie) do
    {
        "id" => movie.id,
        "title" => movie.title
    }
  end

  let (:seriaized_movie_2) do
    {
        "id" => movie_2.id,
        "title" => movie_2.title
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