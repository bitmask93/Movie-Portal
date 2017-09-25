class VerifyController < ApplicationController

def verifymov
if session[:em]
@em = session[:em]
else

@em=[]

end
session[:em]= nil

end

def movieadded
@errarr=[]
@x=Movie.find(params[:id])
@x.verify = 1
@x.save
@errarr.push 'Successfully added Movie : ' + @x.mn
session[:em] = @errarr
puts(params[:id])
redirect_to controller: 'verify', action: 'verifymov'

end

def moviedeleted
@errarr=[]
puts(params[:id])
@x = Movie.find(params[:id])
@x.destroy
@y = Acted.where(:mid=>params[:id])
  if(@y.size==0)
    else
    @y.each do |pp|
    pp.destroy
end
end
@z = Direct.where(:mid=>params[:id]) 
if(@z.size==0)
    else
@z.each do |qq|
qq.destroy
end
end
@errarr.push 'Successfully deleted the Movie : ' + @x.mn

redirect_to controller: 'verify', action: 'verifymov'


end

def verifycomm


end

def ignore
puts(params[:id])
@a1 = Comment.find(params[:id])
@a1.reports = 0
@a1.save
@a2 = Report.where(:cid => params[:id])
if(@a2.size==0)
    else         
	 @a2.each do |qq|
         qq.destroy
end
end


redirect_to controller: 'verify', action: 'verifycomm'
end

def commdel

@a1 = Comment.find(params[:id])
@a1.destroy
@a2 = Report.where(:cid => params[:id])
if(@a2.size==0)
    else         
	 @a2.each do |qq|
         qq.destroy
end
end


redirect_to controller: 'verify', action: 'verifycomm'
end

end
