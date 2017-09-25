require 'digest'
class LoginController < ApplicationController

def index
#session[:em]= nil
if session[:em]

@em = session[:em]
else

@em=[]

end
session[:em]= nil
end

def compute_hash(password, salt)
  digestor = Digest::SHA1.new
  input = digestor.hexdigest(salt + password)

  1000.times.inject(input) do |reply|
    digestor.hexdigest(reply)
  end
end
def select
	if(params[:contactmethod]=='add_mov') 
		redirect_to controller: 'addmov', action: '_addmov',id: session[:id]
	elsif(params[:contactmethod]=='add_act') 
		redirect_to controller: 'actors', action: 'addactors',id: session[:id]
	elsif(params[:contactmethod]=='add_dir') 
		redirect_to controller: 'directors', action: 'adddir',id: session[:id]
	elsif(params[:contactmethod]=='verify_mov') 
		redirect_to controller: 'verify', action: 'verifymov',id: session[:id]
	end

end


def create
   salt = rand(10000)
	@errarr=[]
        @a1 = User.new
	func = params[:fn]
	if(func.length == 0)
		@errarr.push 'First Name should not be Empty'
	end
	emai = params[:em]
        check = User.where(:email=>emai)
	if(check.size!=0)
		@errarr.push 'Email Already exists in the Database'
	end
	pass1 = params[:pw]
	pass2 = params[:cpw]
	if(pass1.length<6)
		@errarr.push 'Password should be of length atleast 7'
	else
		if pass1.eql?(pass2)  
		else
			@errarr.push 'Passwords are different'
		end
         end
     



if(@errarr.size>0)
    session[:em] = @errarr	
    redirect_to action: 'index'
else
@a1.fname = params[:fn]
@a1.lname = params[:ln]
@a1.email = params[:em]
@a1.salt = salt
@a1.pass = compute_hash(params[:pw],salt.to_s)

          a2 = Time.now.strftime('%Y-%m-%d_%H-%M-%S')	
		uploaded_io = params[:picture]
        	if(params[:picture].nil?)
                a4 = 'uploads/user/default.png'
		else
                a3 = a2 + uploaded_io.original_filename 
		a4 = 'uploads/user/' + a3
		
		File.open(Rails.root.join('public', 'uploads', 'user', a3), 'wb') do |file|
  		file.write(uploaded_io.read)
		 #@a1.image = a4
	end
    end
#puts(a4)
@a1.image = a4
@a1.save
#redirect_to action: 'index'
@errarr.push 'Successfully Registered'
session[:em] = @errarr
redirect_to action: 'index'
end
end	  
def admin

end
def users
 

	
end

def usermov

redirect_to controller: 'addmov', action: '_addmov',id: session[:id]

end


def login
    
    @a2 = Admin.new
    @a3 = User.new
    ema = params[:eml]
    #id1 = Admin.where(:email=>ema)
    @errarr=[]
    if(params[:contactmethod]=='admin') 
    	check = Admin.where(:email=>ema)
		if(check.size==0)
			@errarr.push 'Email Does not exist in the Database'
			session[:em] = @errarr	
    			redirect_to action: 'index'
		else
			pass1 = params[:pwd]
			salt1 = check[0].salt
			pass2 = compute_hash(pass1,salt1.to_s)
			#puts(pass2)
				if pass2.eql?(check[0].pass)
					session[:id] =  check[0].id
					session[:email]=check[0].email
					redirect_to action: 'admin'
				else
					@errarr.push 'Incorrect Password'
					session[:em] = @errarr	
    					redirect_to action: 'index'			
				end					
		end
     else
	
check = User.where(:email=>ema)
		if(check.size==0)
			@errarr.push 'Email Does not exist in the Database'
			session[:em] = @errarr	
    			redirect_to action: 'index'
		else
			pass1 = params[:pwd]
			salt1 = check[0].salt
			pass2 = compute_hash(pass1,salt1.to_s)
			#puts(pass2)
				if pass2.eql?(check[0].pass)
					session[:id] =  check[0].id
					session[:email]=check[0].email
					redirect_to controller: 'welcome', action: 'index'
				else
					@errarr.push 'Incorrect Password'
					session[:em] = @errarr	
    					redirect_to action: 'index'			
				end					
		end
        end  
    end
  
def logout

session[:id] = nil
redirect_to controller: 'welcome', action: 'index'


end
end
