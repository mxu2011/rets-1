require 'rets'
require 'json'
require '../common'

# glacier is actually BRC with different credential

# Pass the :login_url, :username, :password and :version of RETS
client = Rets::Client.new({
                              login_url: 'http://reb.retsiq.com/contactres/rets/login',
                              username: 'RETSREWDOTCAGVIC',
                              password: '93X63IYUQ',
                              version: 'RETS/1.7.2'
                          })


# Get all photos (*) for MLS ID 'mls_id'
# Pass :object_id (ie '0', '1,2', wildcard '*')
# The pass :resource (Property, Agent, MetaData, ...), :object_type (Photo, PhotoLarge), :rescource_id (ID of agent, MLS, ...)
photos = client.objects '*', {
  resource: 'Property',
  object_type: 'Photo',
  resource_id: '262218062' # for glacier, this is mls_num
}

Common::process_photos(photos)

client.logout
