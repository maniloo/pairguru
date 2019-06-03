class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    pairguru_app_url + (video_details["poster"] || "")
  end

  def rating
    video_details["rating"] || ""
  end

  def description
    video_details["plot"] || ""
  end


  private

  def pairguru_app_url
    "https://pairguru-api.herokuapp.com"
  end

  def video_details
    @video_details ||= parse_api_response
  end

  def parse_api_response
    response = JSON.parse(api_response)
    response_data = response["data"]
    return {} if response_data.nil?
    response_data["attributes"] || {}
  end

  def api_response
    begin
      RestClient::Request.execute(
          method: :get,
          url: pairguru_app_url + "/api/v1/movies/#{title.gsub(" ", "%20")}",
          headers: {}
      )
    rescue
      "{}"
    end
  end
end
