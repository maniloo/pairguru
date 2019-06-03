# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  validates_with TitleBracketsValidator
  belongs_to :genre

  scope :api_v1_collection, -> do
    select("movies.id, movies.title")
  end

  scope :api_v2_collection, -> do
    joins(:genre)
         .select(
             :id,
             :title,
             :genre_id,
             "genres.name as genre_name",
             )
         .select("(SELECT count(movies.id)
                      FROM movies
                      WHERE movies.genre_id = genres.id) as movies_in_genre"
         )
  end
end
