class DirectorsController < ApplicationController

def adddir
@em=[]

if(request.method == 'GET')

@em=session[:em]
	if(@em.nil?)
	@em=[]
	end
	session[:em]= nil
else
@dir = Director.new

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
   if(params[:notes].length<=20)
	@errarr.push 'Description must be atleast 20 characters'			       
   end     

   if(@errarr.size>0)
        session[:em] = @errarr	
        redirect_to action: 'adddir'
   else
	@dir.fname = params[:fname]
	@dir.lname = params[:lname]
	@dir.dob = params[:dob]
	@dir.note = params[:notes]	
	uploaded_io = params[:picture]
        a3 = a2 + uploaded_io.original_filename 
	a4 = 'uploads/directors/' + a3
	File.open(Rails.root.join('public', 'uploads', 'directors', a3), 'wb') do |file|
  	file.write(uploaded_io.read)
   end
	@dir.image = a4
        @dir.save
        @errarr.push 'Successfully added the Director' + params[:fname] + ' ' + params[:lname]
	session[:em] = @errarr
        redirect_to action: 'adddir'
   end 
 



end
 
end
def destroydir
	 @x = Director.find(params[:id])
    	 @x.destroy
         @z = Direct.where(:did=>params[:id]) 
	 if(@z.size==0)
	 else         
	 @z.each do |qq|
         qq.destroy
end
end

	 redirect_to controller: 'login', action: 'admin' 
end

def editdirector

#@em=[]
@x=Director.find(params[:id])
@act1=@x
if(request.method == 'GET')
@em=session[:em]
	if(@em.nil?)
	@em=[]
	end
	session[:em]= nil
else

@errarr1=[]
a1 = session[:id] 
a2 = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
   if(params[:picture].nil?)
	@errarr1.push 'Image field should not be Empty'
   end
   if(params[:fname].length == 0)
	@errarr1.push 'First Name should not be Empty'
   end	
    if(params[:dob].length == 0)
	@errarr1.push 'Date of birth should not be Empty'
   end
   if(params[:notes].length<=20)
	@errarr1.push 'Description must be atleast 20 characters'			       
   end     

   if(@errarr1.size>0)
        session[:em] = @errarr1	
        redirect_to action: 'addactors'
   else
	@act1.fname = params[:fname]
	@act1.lname = params[:lname]
	@act1.dob = params[:dob]
	@act1.note = params[:notes]	
	uploaded_io = params[:picture]
        a3 = a2 + uploaded_io.original_filename 
	a4 = 'uploads/directors/' + a3
	#puts(a4)
	File.open(Rails.root.join('public', 'uploads', 'directors', a3), 'wb') do |file|
  	file.write(uploaded_io.read)
   end
	@act1.image = a4
        @act1.save
        #@errarr1.push 'Successfully added the Director' + params[:fname] + params[:lname]
  	#session[:em] = @errarr1
        redirect_to controller: 'login', action: 'admin' 
   end 
 end
end
end
