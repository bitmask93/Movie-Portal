require 'digest'
class LoginController < ApplicationController

def index
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
	end

end


def create
   salt = rand(10000)
	@errarr=[]
        @a1 = Admin.new
	func = params[:fn]
	if(func.length == 0)
		@errarr.push 'First Name should not be Empty'
	end
	emai = params[:em]
        check = Admin.where(:email=>emai)
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

def login
    @a2 = Admin.new
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
					redirect_to action: 'admin',id: session[:id]
				else
					@errarr.push 'Incorrect Password'
					session[:em] = @errarr	
    					redirect_to action: 'index'			
				end					
		end
     else
	redirect_to action: 'users'
     end  
    end
end
