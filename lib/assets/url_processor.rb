
class UrlProcessor

  def initialize(options = {})
    self.links = options[:links] if options.has_key? :links 
  end

  def links= links 
    @_links = links 
  end

  def links 
    @_links 
  end

  def process
    return unless @_links

    @_health = []

    @_links.each do | link | 
      # Get the code
      health = get_link_health link

      # Save the code
      @_health << health 
    end
  end

  def health= health 
    @_health = health
  end

  def health 
    @_health
  end

  private

  def get_link_health link
    begin 
      require 'uri'
      require 'net/http'
      link  = url_preprocess link
      url   = URI.parse( link )
    
      http  = Net::HTTP.start(url.host, url.port, {open_timeout: 5, read_timeout: 5}) 
      path  = url.path 
      path  = "/" if path == ""
      res   = http.get(path)
      # Generate helath object
      return UrlHealth.new( host: url.host, port: url.port, code: res.code, path: link )

    rescue Exception => e 
      binding.pry
      return nil
    end

    return nil
  end

  def url_preprocess url 
    URI.parse( url ).scheme.nil? ? "http://#{url}" : url 
  end

end