class SiteController < ApplicationController
  helper SiteHelper

  def index 

  end

  def contact

  end

  def check
    # String array of links to be processed
    links = split_urls( params[:list] )
    # Creatng url processor
    url_processor = UrlProcessor.new( links: links )
    url_processor.process
    url_health = url_processor.health
    # binding.pry
    @health_list = url_health
  end

  private
  def split_urls string 
    items = string.split ','
    items.each do | item | 
      item.strip!
    end
    items
  end 

end
