require 'date' 
require 'base64'
require 'metainspector'
require 'urls_controller'

class Url < ApplicationRecord

  # This short_url generator is too simple, uses Base64 module and the initials chars of the original_url variable to generate a code.
  # Starts using the char number 1 of the string original_url to generate the Base64 code, and take another and another char to 
  # generate a new code if that code already exist on the database.
  def generate_short_url(domain_name)
    var = 2
    loop do
      self.short_url = domain_name + (Base64.encode64(self.original_url)[0..var])
      if Url.find_by_short_url(self.short_url).nil?
        break
      else
        var = var + 1
      end
    end
  end

  # Look if the url given already was shortened  
  def find_duplicate
    Url.find_by_original_url(self.original_url)
  end

  # Find duplicate using short_url
  def find_by_short_url(short_url)
    Url.find_by_short_url(short_url)
  end

  # Update count of visits
  def update_visits(short_url)
    url = Url.find_by_short_url(short_url)
    url.visit_count = url.visit_count + 1
    url.save
  end

  # Return true if the url given already was shortened
  def new_url?
    find_duplicate.nil?
  end

  # Generate a date with friendly format 
  def generate_date_shortened
    self.date_shortened = Time.now.strftime("%d/%m/%Y %H:%M")
  end

  # Sanitize and check if URL given has a valid format
  def valid_url?
    begin
      self.original_url.strip!
      self.original_url.slice!(-1) if self.original_url[-1] == "/"
      page = MetaInspector.new(self.original_url)
      true
    rescue
      false
    end
  end

  # Gets the top 100 board
  def top_board
    Url.order(visit_count: :asc).limit(100).reverse
  end
end
