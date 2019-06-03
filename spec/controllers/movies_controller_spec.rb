require "rails_helper"

RSpec.describe MoviesController do
  let!(:movie) do
    create(:movie, title: "Kill Bill", description: "Not existing description")
  end
  let(:base_url) { "https://pairguru-api.herokuapp.com" }

  describe "index acion" do
    describe "renders the movies info with data from API" do
      before do
        visit movies_path
      end

      it "renders poster from api" do
        image_element = find_all("tr img.poster")[0]
        image_src = image_element["src"]

        expect(image_src).to include(base_url)
        expect(image_src.length).to be > base_url.length
      end

      it "shows rating from API" do
        rating_element = find("p", text: "Rating")

        expect(rating_element.text).not_to eq("Rating")
      end

      it "shows description from API" do
        description_element = find("p.description")

        expect(description_element.text).not_to eq(movie.description)
        expect(description_element.text).not_to eq("")
        end
    end

    describe "show action" do
      describe "renders the movie info with data from API" do
        before do
          visit movie_path(movie)
        end

        it "renders poster from api" do
          image_element = find_all("img.poster")[0]
          image_src = image_element["src"]

          expect(image_src).to include(base_url)
          expect(image_src.length).to be > base_url.length
        end

        it "shows rating from API" do
          rating_element = find("p", text: "Rating")

          expect(rating_element.text).not_to eq("Rating")
        end

        it "shows description from API" do
          description_element = find("p.description")

          expect(description_element.text).not_to eq(movie.description)
          expect(description_element.text).not_to eq("")
        end
      end
    end
  end
end