module SiteHelper

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
      req = Net::HTTP.new(url.host, url.port)
      res = request_head(url.path)

      return true if res.code == '200'

    rescue Exception => e 
      return false
    end

    return false
    
  end

end
