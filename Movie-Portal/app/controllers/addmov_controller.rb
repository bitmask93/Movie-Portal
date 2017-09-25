class AddmovController < ApplicationController

def _addmov
#puts(session[:eml])

@em=[]
if(request.method == 'GET')
a1 = session[:id]
a2 = session[:email]
puts(a2) 
@em=session[:em]
	if(@em.nil?)
	@em=[]
	end
	session[:em]= nil
else
	@mov = Movie.new
	
	@dir = Direct.new
	@d1 = Director.new

	re = /(youtube.com)\/(watch)?(\?v=)?(\S+)?/
	@errarr=[] 

	if(params[:mn].length == 0)
		@errarr.push 'Movie Name should not be Empty'
	end 
	if(params[:director].length == 0)
		@errarr.push 'Director Name(s) should not be Empty'
	end 
	if(params[:act].length == 0)
		@errarr.push 'Cast Names cannot be Empty'
	else
		
	end
	if(params[:duration].length == 0)
		@errarr.push 'Movie Name should not be Empty'
	end

	if(params[:dor].length == 0)
		@errarr.push 'Date Of Release should not be Empty'
	end

	if(params[:video].length == 0)
		@errarr.push 'Trailer Link should not be Empty'
	elsif(params[:video].match(re).nil?) 
		@errarr.push 'Enter a valid Youtube Link'
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
	else
	
	@mov.mn = params[:mn]
	@mov.video = params[:video]
	@mov.dor = params[:dor]
	@mov.dur = params[:duration]
	@mov.gen1 = params[:gen1]
	@mov.gen2 = params[:gen2]
	@mov.note = params[:description]
	checkadmin = Admin.where(:email => session[:email])
	if(checkadmin.size == 0)
		puts('not admin')
		@errarr.push params[:mn] + ' ' + 'is waiting for confirmation from admin'
	else	
		@mov.verify = 1
		 @errarr.push 'Successfully added the Movie' + ' ' + params[:mn]
	end
		@casts = params[:act].split(',')
		@casts.each do |x|
			@c1 = Cast.new
	        	fn1 = x.split(' ')[0]
			fn2 = x.split(' ')[1]
			check1 = Cast.where(:fname=>fn1).where(:lname=>fn2)
			if(check1.size == 0)
				@c1.fname = fn1
				@c1.lname = fn2
				a6 = 'uploads/actors/default.png'
                                @c1.image = a6
				@c1.save
				puts(@c1.id)
			end
			
				
				
		end
				
		puts(params[:description])
		puts()
		a2 = Time.now.strftime('%Y-%m-%d_%H-%M-%S')	
		uploaded_io = params[:picture]
        	a3 = a2 + uploaded_io.original_filename 
		a4 = 'uploads/movies/' + a3
		#puts(a4)
		File.open(Rails.root.join('public', 'uploads', 'movies', a3), 'wb') do |file|
  		file.write(uploaded_io.read)
		
	end
		 @mov.photo = a4
        	 @mov.save
		# @errarr.push 'Successfully added the Movie' + ' ' + params[:mn]
        	 session[:em] = @errarr	
		 
		 puts(@mov.id)
			@direct = params[:director].split(' ')
			direct1 = @direct[0]
			direct2 = @direct[1]
			   check = Director.where(:fname=>direct1).where(:lname=>direct2)
			if(check.size == 0)
				@d1.fname = direct1
				@d1.lname = direct2
                                a6 = 'uploads/actors/default.png'
                                @d1.image = a6
				@d1.save
				#@dir.did = @d1.id				
			else
				#@dir.did = check[0].id					
				#puts("Already in the database")								
			end 

#redirect_to action: '_addmov'


@direct = params[:director].split(' ')
direct1 = @direct[0]	
direct2 = @direct[1]	
check3 = Director.where(:fname=>direct1).where(:lname=>direct2)
if(check3.size == 0)
				
	else
		puts(check3[0].id)
		@dir.mid = @mov.id
		@dir.did = check3[0].id
		@dir.save
			end
			






		@casts = params[:act].split(',')
		@casts.each do |x|
			@ac = Acted.new
	        	fn1 = x.split(' ')[0]
			fn2 = x.split(' ')[1]
			check1 = Cast.where(:fname=>fn1).where(:lname=>fn2)
			if(check1.size == 0)
				
			else
				puts(check1[0].id)
				@ac.mid = @mov.id
				@ac.cid = check1[0].id
				@ac.save
			end
			
			
				
				
		end





redirect_to action: '_addmov'



















	end
end
end
end
