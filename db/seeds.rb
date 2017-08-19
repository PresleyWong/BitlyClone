require "securerandom"

inserts=[]

File.open('db/data/urls').each_line do |data|
	inserts << "('#{data[1..-4]}', '#{SecureRandom.hex(3)}')"
end

sql="INSERT INTO urls (long_url, short_url) VALUES #{inserts.join(", ")}"


Url.connection.execute sql
