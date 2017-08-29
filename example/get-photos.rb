require 'rets'


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
  File.open("property-#{index.to_s}.jpg", 'w') do |file|
    file.write data.body
  end
end

puts photos.length.to_s + ' photos saved.'
client.logout
