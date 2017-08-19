class CreateUrl < ActiveRecord::Migration
	def change
			create_table :urls do |t|
	        t.text  	:long_url, uniqueness: true
	        t.text  	:short_url, uniqueness: true
	        t.integer 	:click_count, default: 0	
	 	end
	end
end

=begin
reference: 
https://learn.co/lessons/sinatra-forms-params-readme-walkthrough
=end
