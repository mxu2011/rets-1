require 'rets'
require 'json'


# Pass the :login_url, :username, :password and :version of RETS
client = Rets::Client.new({
                              login_url: 'http://reb.retsiq.com/contactres/rets/login',
                              username: 'RETSREWDOTCA',
                              password: '!R3007E5TA7E!@!',
                              version: 'RETS/1.7.2'
                          })


# Get all photos (*) for MLS ID 'mls_id'
# Pass :object_id (ie '0', '1,2', wildcard '*')
# The pass :resource (Property, Agent, MetaData, ...), :object_type (Photo, PhotoLarge), :rescource_id (ID of agent, MLS, ...)
photos = client.objects '*', {
  resource: 'Property',
  object_type: 'Photo',
  resource_id: '262218062'  # for BRC, this is remote_sysid
}

photos.each_with_index do |data, index|
  seq = data.headers['object-id'] if data.respond_to? ('headers')

  puts "object-id=#{seq}, index=#{index}"

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
