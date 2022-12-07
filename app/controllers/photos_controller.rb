class PhotosController < ApplicationController
  def index
      matching_photos = Photo.all

      @list_of_photos = matching_photos.order({ :created_at => :desc })

      render({ :template => "photos/index.html.erb" })
  end
  
  def profile 
    
    profile_id = params.fetch("path_id")
    @cu = params.fetch("path_id")
    @profile_own = User.where(:id=> profile_id).first
    @status = MootsRequest.where(:sender_id=>@current_user.id).where(:recipient_id=>@profile_own.id).first
   
   if @current_user.id == @cu
    redirect_to("mycloset/index.html.erb" )
   elsif @profile_own.private == nil 
      if @status != nil 
        all_pics = Photo.all 
        profile_photos = all_pics.where(:owner_id => profile_id)
        @pics = profile_photos.order({ :created_at => :desc })
        @profiler = profile_photos.first
        render({ :template => "photos/profile.html.erb" })
      else 
        all_pics = Photo.all 
        profile_photos = all_pics.where(:owner_id => profile_id)
        @pics = profile_photos.order({ :created_at => :desc })
        @profiler = profile_photos.first
        render({ :template => "photos/profile_not_followed.html.erb" })
      end
    elsif MootsRequest.where(:sender_id=>@current_user.id).where(:recipient_id=>@profile_own.id).exists?
      all_pics = Photo.all 
      profile_photos = all_pics.where(:owner_id => profile_id)
      @pics = profile_photos.order({ :created_at => :desc })
      @profiler = profile_photos.first
      render({ :template => "photos/profile_private.html.erb" })
    else 
      all_pics = Photo.all 
      profile_photos = all_pics.where(:owner_id => profile_id)
      @pics = profile_photos.order({ :created_at => :desc })
      @profiler = profile_photos.first
      render({:template=>"photos/profile_private.html.erb"})
   end 
  end
  
  def myfits
    the_id = session.fetch(:user_id)
    user_photos = Photo.where(:owner_id=>the_id)
    
    @my_photos = user_photos.order({ :created_at => :desc })
    @profile_owner = @current_user
    render({ :template => "photos/myfits.html.erb" })
  end 



  def new_photo_form
  
  render("photos/new_photo_form.html.erb")  
  end

  def create
    the_photo = Photo.new
    the_photo.caption = params.fetch("query_caption")
    the_photo.image = params.fetch("image")
    the_photo.owner_id = @current_user.id
    the_photo.location = params.fetch("query_location")
    the_photo.likes_count = 0
    the_photo.comments_count = 0

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos", { :notice => "Photo created successfully." })
    else
      the_photo.save
      redirect_to("/photos", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.caption = params.fetch("query_caption")
    the_photo.image = params.fetch("query_image")
    the_photo.owner_id = params.fetch("query_owner_id")
    the_photo.location = params.fetch("query_location")
    the_photo.likes_count = params.fetch("query_likes_count")
    the_photo.comments_count = params.fetch("query_comments_count")

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos/#{the_photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{the_photo.id}", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end

def show
  the_id = params.fetch("path_id")

  matching_photos = Photo.where({ :id => the_id })

  @the_photo = matching_photos.at(0)

  @profile_id = @the_photo.owner_id

  @viewer_id = @current_user.id
  
  @profile_own = User.where(:id=> @profile_id).first
  @status = MootsRequest.where(:sender_id=>@current_user.id).where(:recipient_id=>@profile_own.id).first
  @liked = Like.where(:photo_id=>@the_photo.id).where(:user_id=>@current_user.id).first
  
 if @current_user.id == @profile_id
  render({ :template => "photos/show.html.erb" })
 elsif @profile_own.private == nil 
    all_pics = Photo.all 
    profile_photos = all_pics.where(:owner_id => @profile_id)
    @pics = profile_photos.order({ :created_at => :desc })
    @profiler = profile_photos.first
  render({ :template => "photos/show.html.erb" })
 elsif @status==nil 
  render({:template =>"photos/show_private.html.erb"})
 else 
  all_pics = Photo.all 
  profile_photos = all_pics.where(:owner_id => @profile_id)
  @pics = profile_photos.order({ :created_at => :desc })
  @profiler = profile_photos.first
  render({ :template => "photos/show.html.erb" })
 end 

  
end

end
