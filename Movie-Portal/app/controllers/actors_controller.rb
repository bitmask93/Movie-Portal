class ActorsController < ApplicationController


def addactors
@em=[]

if(request.method == 'GET')

@em=session[:em]
	if(@em.nil?)
	@em=[]
	end
	session[:em]= nil
else
@act = Cast.new
@errarr=[]
a1 = session[:id] 
a2 = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
   if(params[:picture].nil?)
	@errarr.push 'Image field should not be Empty'
   end
   if(params[:fname].length == 0)
	@errarr.push 'First Name should not be Empty'
   end	
    if(params[:dob].length == 0)
	@errarr.push 'Date of birth should not be Empty'
   end
   if(params[:dob].length == 0)
	@errarr.push 'Date of birth should not be Empty'
   end
   if(params[:notes].length<=20)
	@errarr.push 'Synopsis must be atleast 20 characters'			       
   end     

   if(@errarr.size>0)
        session[:em] = @errarr	
        redirect_to action: 'addactors'
   else
	@act.fname = params[:fname]
	@act.lname = params[:lname]
	@act.dob = params[:dob]
	@act.note = params[:notes]	
	uploaded_io = params[:picture]
        a3 = a2 + uploaded_io.original_filename 
	a4 = 'uploads/actors/' + a3
	#puts(a4)
	File.open(Rails.root.join('public', 'actors', a3), 'wb') do |file|
  	file.write(uploaded_io.read)
   end
	@act.image = a4
        @act.save
        @errarr.push 'Successfully added the Actor' + params[:fname] + params[:lname]
        redirect_to action: 'addactors'
   end 
 



end
 
end

end
