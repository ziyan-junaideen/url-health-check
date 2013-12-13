class SiteController < ApplicationController
  helper SiteHelper

  def index 

  end

  def contact

  end

  def check
    @list = [] 
    list = split_urls( params[:list] )
    @health_list = process_urls( list )
  end

  private

  def split_urls s
    parts = s.split(',')
    urls = []
    parts.each do | part |
      urls << part.strip
    end
    urls
  end

  def check_url u 
    
    begin 
      
      require 'net/http'
      url = URI.parse(u)
      req = Net::HTTP.start(url.host, url.port, {open_timeout: 5, read_timeout: 5})
      
      if url.path != ''
        path = url.path 
      else 
        path = '/'
      end
      
      res = req.head(path)
      
      return res.code

    rescue Exception => e 
      binding.pry
      return false
    end

    return false

  end

  def process_urls urls

    url_helth_list = []

    urls.each do | url |
      status = check_url( url )
      if check_url url
        url_helth_list << UrlHealth.new( path: url, valid: status ) 
      end
    end

    return url_helth_list
  end


end
