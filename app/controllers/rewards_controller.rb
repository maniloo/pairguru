class RewardsController < ApplicationController
  def index
    @comments = Comment
                    .where("comments.created_at > ?", Time.zone.now - 7.days)
                    .joins(:user)
                    .select("users.name as user_name, count(comments.id) as num_of_comments")
                    .group("users.id")
                    .order("num_of_comments desc")
                    .limit(10)
  end
end