module Api
  module V1
    class MoviesController < ApplicationController

      def index
        render json: movie_colleciton
      end

      def show
        render json: movie_colleciton.find(params[:id])
      end

      private

      def movie_colleciton
        Movie.api_v1_collection
      end
    end
  end
end