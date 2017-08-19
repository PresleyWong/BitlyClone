
#enable :sessions


get '/' do
	#@Message = session[:msg]
	#session[:msg] = nil
	@array_url = Url.all.order(:id).reverse_order.paginate(page: params[:page], per_page: 10)
 	erb :"static/index"
end

post '/urls' do

	puts "log - 1"
	@url = Url.new(params[:url])  #this will trigger before_create callback method

	str=@url.long_url
	str.downcase!
    str_http =/^[w]{3}/.match(str)
    str = "http://"+str if str_http != nil
    @url.long_url=str

    puts "log - 2"
	if @url.save
		puts "log - 3"
		#session[:msg] = "Shorten URL: #{@url.short_url}"
		return @url.to_json(except: :id)    #return to client
    else
    	#session[:msg] = "Invalid URL"    		
	end
end


get '/:short_url' do

	url = Url.find_by(short_url: params[:short_url])

	if url
		url.increment!(:click_count)
		url.to_json(except: :id)
		redirect url.long_url
	else
		redirect '/'
	end

end


