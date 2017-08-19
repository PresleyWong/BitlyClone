class Url < ActiveRecord::Base
 	validates :long_url, presence: true , uniqueness: true   , format:{ with:/w{3}[.].+[.]/, message:"Invalid URL"}
 	validates :short_url, uniqueness: true
  	#before_save :shorten , if: :new_record?  
  	before_create :shorten   #shorten will be called before save 

	def shorten
		puts "log - shorten"
		bool_exist = true
		int_trial_count = 0
		string_alphabet = "a".."z"
		array_alphabet = string_alphabet.to_a

		string_number = "0".."9"
		array_number = string_number.to_a

		while bool_exist 

			string_random = ""
			int_trial_count += 1

			Url.destroy_all if int_trial_count > 1000000

			while string_random.length < 7
								
				bool_number = [true, false].sample

				if bool_number == true
					string_sample = array_number.sample
				else
					string_sample = array_alphabet.sample

					bool_upcase = [true, false].sample				
					string_sample.upcase! if bool_upcase == true				
				end

				string_random << string_sample
			end

			bool_exist = Url.exists?(short_url: string_random)
		end
		

		self.short_url = string_random 

	end

end
