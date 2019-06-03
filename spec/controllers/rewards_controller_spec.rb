require "rails_helper"

RSpec.describe RewardsController do
  let!(:user_1) { create :user }
  let!(:user_2) { create :user }
  let!(:user_3) { create :user }
  let!(:movie_1) { create :movie }
  let!(:movie_2) { create :movie }
  let!(:movie_3) { create :movie }
  let!(:comment_1) { create :comment, movie: movie_1, user: user_1 }
  let!(:comment_2) { create :comment, movie: movie_2, user: user_1 }
  let!(:comment_3) { create :comment, movie: movie_3, user: user_1 }
  let!(:comment_4) { create :comment, movie: movie_1, user: user_2 }
  let!(:comment_5) { create :comment, movie: movie_2, user: user_2 }
  let!(:comment_6) { create :comment, movie: movie_3, user: user_3 }

  describe "index action" do
    before do
      visit rewards_path
    end

    it "show user wich add most comments in last 7 days" do
      rows = find_all("p.reward")
      authors = find_all("span.author")
      num_of_comments = find_all("span.num_of_comments")

      expect(rows.length).to eq(3)
      expect(authors[0].text).to eq(user_1.name)
      expect(authors[1].text).to eq(user_2.name)
      expect(authors[2].text).to eq(user_3.name)
      expect(num_of_comments[0].text).to eq("3")
      expect(num_of_comments[1].text).to eq("2")
      expect(num_of_comments[2].text).to eq("1")
    end
  end
end