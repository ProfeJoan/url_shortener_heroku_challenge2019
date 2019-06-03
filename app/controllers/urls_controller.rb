require 'sidekiq'
require 'get_url_title_job'

class UrlsController < ApplicationController

  @@DOMAIN_NAME = "http://localhost:3000/"

  def show
    begin
      url = Url.new
      original_url = url.find_by_short_url(@@DOMAIN_NAME + params[:short_url]).original_url
      url.update_visits(@@DOMAIN_NAME + params[:short_url])
      redirect_to original_url
    rescue
      redirect_to shortened_path(original_url: url.original_url, short_url: "", title: "", visit_count: "", date_shortened: "", obs: "\"" + @@DOMAIN_NAME + params[:short_url] + "\" -> is not a Short URL  0_0")
      redirect_to controller: 'thing', action: 'edit', id: 3, something: 'else'
    end
  end

  def create
    # Create de object and set every parameter of a new URL record
    url = Url.new
    url.original_url = params[:original_url]
    if url.valid_url?
      if url.new_url?
        url.generate_short_url(@@DOMAIN_NAME)
        url.title = "Waiting for job trigger..."
        url.visit_count = 0
        url.generate_date_shortened    
        url.save
        job = GetUrlTitleJob.new
        job.get_title(url.short_url)
        redirect_to shortened_path(original_url: url.original_url, short_url: url.short_url, title: url.title, visit_count: url.visit_count, date_shortened: url.date_shortened, obs: "New shortened")
      else
        redirect_to shortened_path(original_url: url.original_url, short_url: url.find_duplicate.short_url, title: url.find_duplicate.title, visit_count: url.find_duplicate.visit_count, date_shortened: url.find_duplicate.date_shortened, obs: "Before shortened")
      end
    else
      redirect_to error_path(original_url: url.original_url, short_url: "", title: "", visit_count: "", date_shortened: "", obs: "URL unreachable or has invalid format  (0_0)")
    end
  end

  def top
    url = Url.new
    @top = url.top_board
    #redirect_to top_path(top: top)
  end
end
