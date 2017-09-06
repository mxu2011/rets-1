require 'rets'
require 'json'
require '../common'


# Pass the :login_url, :username, :password and :version of RETS
client = Rets::Client.new({
                              login_url: 'http://matrix.buywhistler.com/rets/login.ashx',
                              username: 'rewwls',
                              password: 'powder',
                              version: 'RETS/1.7.2'
                          })


# Get all photos (*) for MLS ID 'mls_id'
# Pass :object_id (ie '0', '1,2', wildcard '*')
# The pass :resource (Property, Agent, MetaData, ...), :object_type (Photo, PhotoLarge), :rescource_id (ID of agent, MLS, ...)
photos = client.objects '*', {
  resource: 'Property',
  object_type: 'LargePhoto',
  resource_id: '303' # for wls, this is mls_num
}

Common::process_photos(photos)

puts photos.length.to_s + ' photos saved.'
client.logout
