class ViewController < ApplicationController

def viewmov

end
  

def viewact


end


def viewdir


end

def viewall

end



def addrating
if(params[:r1].length==0)
redirect_to controller: 'view', action:  'viewmov' ,id: params[:movid]  
puts("Not Added")
else
	@rat = Rate.new
	@rat.uid = session[:id]
	@rat.mid = params[:movid]
	@rat.rating = params[:r1]
	@rat.save
        redirect_to controller: 'view', action:  'viewmov' ,id: params[:movid]  
end
end

def comments
@com = Comment.new
if(params[:comment].length==0)
   redirect_to controller: 'view', action:  'viewmov' ,id: params[:movid]
else
   @com.uid = session[:id]
   @com.mid = params[:movid]
   @com.comment = params[:comment]  
   @com.save
redirect_to controller: 'view', action:  'viewmov' ,id: params[:movid]  
end
end

def destroycomm
	 @x = Comment.find(params[:cid])
         @y = Report.where(:cid=>params[:cid])  
         if(@y.size==0)
              puts("Database has no value ")
         	else
		@y.each do |pp|
		pp.destroy
       		end
	end
    	 @x.destroy
	 redirect_to controller: 'view', action:  'viewmov' ,id: params[:movid]  

end

def reportcomm
	@rep = Report.new
        @rep.uid = session[:id]
        @rep.mid = params[:movid]
        @rep.cid = params[:cid]
        @rep.save
        #@a1 = Comment.new
        @a2 = Comment.where(:id=>params[:cid])
        @a2[0].reports = @a2[0].reports + 1
        @a2[0].save 
        redirect_to controller: 'view', action:  'viewmov' ,id: params[:movid]  
end




end
