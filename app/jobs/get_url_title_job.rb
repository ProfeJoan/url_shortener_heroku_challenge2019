require 'metainspector'

class GetUrlTitleJob < ApplicationJob
  queue_as :default

  #rescue_from(ErrorLoadingSite) do
   # retry_job wait: 5.minutes, queue: :low_priority 
  #end  

  def get_title(short_url)
    begin
	    url = Url.find_by_short_url(short_url)
	    page = MetaInspector.new(url.original_url)
	    url.title = page.title #"MetaInspector test..."
	    url.save
	rescue
		url = Url.find_by_short_url(short_url)
	    url.title = "Page title unreachable"
	    url.save
	end
  end
end
