class AddmovController < ApplicationController

def _addmov
@em=[]
if(request.method == 'GET')

@em=session[:em]
	if(@em.nil?)
	@em=[]
	end
	session[:em]= nil
else
	re = /(youtube.com)\/(watch)?(\?v=)?(\S+)?/
	@errarr=[] 

	if(params[:mn].length == 0)
		@errarr.push 'Movie Name should not be Empty'
	end
	
	if(params[:act].length == 0)
		@errarr.push 'Cast Names cannot be Empty'
	else
		@casts = params[:act].split(',')
		@casts.each do |x|
		puts(x)	
	end
	end
	if(params[:duration].length == 0)
		@errarr.push 'Movie Name should not be Empty'
	end

	if(params[:dor].length == 0)
		@errarr.push 'Date Of Release should not be Empty'
	end

	if(params[:video].length == 0)
		@errarr.push 'Trailer Link should not be Empty'
	elsif(params[:video].match re?nil) 
		@errarr.push 'Enter a valid Youtube Link'
	else
		puts("Success")
	end

	if(params[:gen1].length == 0)
		@errarr.push 'Genre1 should not be Empty'	
	end

	if(params[:gen2].length == 0)
		@errarr.push 'Genre2 should not be Empty'	
	end

	if(params[:description].length <= 50)
		@errarr.push 'Synopsis should be of length atlast 50'	
	end
   
	if(@errarr.size>0)
        session[:em] = @errarr	

        redirect_to action: '_addmov'
	end



	
end
end

end
