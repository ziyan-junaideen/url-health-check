class UrlHealth
  
  def initialize( options = {} )
    @_domain  = options[:domain]  if options.has_key? :domain
    @_port    = options[:port]    if options.has_key? :port
    @_path    = options[:path]    if options.has_key? :path 
    @_code    = options[:code]    if options.has_key? :code
  end

  def domain= domain 
    @_domain = domain 
  end

  def domain 
    @_domain
  end

  def port= port 
    @_port = port 
  end

  def port
    @_port
  end

  def path= path 
    @_path = path 
  end

  def path 
    @_path
  end

  def code= code 
    @_code = code 
  end

  def code 
    @_code 
  end

  def valid?
    invalid = [ 404 ]
    is_invalid = invalid.include? self.code
    return ! is_invalid 
  end

end