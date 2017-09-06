class Common
  def self.process_photos(photos)
    photos.each_with_index do |data, index|
      objectId = data.headers['object-id']

      puts "object-id=#{objectId}, index=#{index}"

      filename = "image-#{objectId.to_s}"

      # write jpg files
      File.open("#{filename}.jpg", 'w') do |file|

        file.write data.body
      end

      # serialize each image data object to a json text file
      File.open("#{filename}.json", 'w') do |file|
        data.body = nil
        file.write(JSON.pretty_generate(data.to_h))
      end

    end
  end
end