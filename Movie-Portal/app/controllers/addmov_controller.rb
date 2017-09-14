class AddmovController < ApplicationController

def _addmov
if(request.method == 'POST') 
@casts = params[:act].split(',')
	@casts.each do |x|
		puts(x)

	end	
	




end
end
end
