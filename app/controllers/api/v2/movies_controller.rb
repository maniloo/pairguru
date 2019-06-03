module Api
  module V2
    class MoviesController < ApplicationController

      def index
        render json: movie_colleciton
      end

      def show
        render json: movie_colleciton.find(params[:id])
      end

      private

      def movie_colleciton
        Movie.api_v2_collection
      end
    end
  end
end