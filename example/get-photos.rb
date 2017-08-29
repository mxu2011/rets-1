require 'rets'
require 'json'


# Pass the :login_url, :username, :password and :version of RETS
client = Rets::Client.new({
                              login_url: 'http://rets.torontomls.net:6103/rets-treb3pv/server/login',
                              username: 'D16nic',
                              password: 'B#65n17',
                              version: 'RETS/1.5'
                          })


# Get all photos (*) for MLS ID 'mls_id'
# Pass :object_id (ie '0', '1,2', wildcard '*')
# The pass :resource (Property, Agent, MetaData, ...), :object_type (Photo, PhotoLarge), :rescource_id (ID of agent, MLS, ...)
photos = client.objects '*', {
  resource: 'Property',
  object_type: 'Photo',
  resource_id: 'W3906742'
}

photos.each_with_index do |data, index|
  seq = data.headers['object-id'] if data.respond_to? ('headers')

  seq = (seq.to_i - 1) if !seq.nil?

  seq ||= index

  # write jpg files
  File.open("image-#{seq.to_s}.jpg", 'w') do |file|

    file.write data.body
  end

  # serialize each image data object to a json text file
  File.open("image-#{seq.to_s}.json", 'w') do |file|
    data.body = nil
    file.write(JSON.pretty_generate(data.to_h))
  end

end

puts photos.length.to_s + ' photos saved.'
client.logout
