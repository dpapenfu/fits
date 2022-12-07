class MyClosetsController < ApplicationController
  def feed 
    
    matching_my_closets = MyCloset.all
    @list_of_my_closets = matching_my_closets.order({ :created_at => :asc })

    @timely_fits = @list_of_my_closets.where("created_at <?", 1.days.ago)
    @followed = MootsRequest.where(:sender_id => @current_user.id).where(:status=>true)
    @viewer_id = @current_user.id

    render({ :template => "my_closets/ootd.html.erb"})
  end

  def index
    the_user = session.fetch(:user_id)
    all_closets = MyCloset.all
    matching_my_closets = all_closets.order({ :created_at => :desc})
    filtered = MootsRequest.where(:status=>nil)
    @mutualr = filtered.where(:recipient_id=>the_user) 
    @my_fits = matching_my_closets.where({ :user_id => the_user })

    render({ :template => "my_closets/index.html.erb" })
  end



  def show
    the_id = params.fetch("path_id")

    matching_my_closets = MyCloset.where({ :id => the_id })

    @the_my_closet = matching_my_closets.at(0)

    @profile_id = @the_my_closet.user_id

    @viewer_id = @current_user.id
    @profile_own = User.where(:id=> @profile_id).first

    @status = MootsRequest.where(:sender_id=>@current_user.id).where(:recipient_id=>@profile_own.id).first
    @liked = FitCheck.where(:my_closet_id=>@the_my_closet.id).where(:user_id=>@current_user.id).first
    
    if @current_user.id == @profile_id
      render({ :template => "my_closets/show.html.erb" })
    elsif @profile_own.private == nil 
    
    elsif @status==nil 
      render({:template =>"my_closets/show_private.html.erb"})
    else 
      render({ :template => "my_closets/show.html.erb" })
    end 
  end

  def new_clothing_form
    render("my_closets/new_clothing_form.html.erb")  
  end 
  def create
    # require "twilio-ruby"
    # AC6cb2c32f288fb66ab198f5273cfbb99c
    the_my_closet = MyCloset.new
    the_my_closet.user_id = session.fetch(:user_id)
    the_my_closet.clothing = params.fetch("clothing")
    the_my_closet.caption = params.fetch("query_caption")
    moots = MootsRequest.where(:recipient_id=>the_my_closet.user_id).where(:status=>true).first
    mootsie = moots.sender_id
    muts = User.where(:id=>mootsie).first
    @moots_nr = muts.fetch(:mobile)

    if the_my_closet.valid?
      the_my_closet.save

      require "twilio-ruby"
      # Get your credentials from your Twilio dashboard, or from Canvas if you're using mine
      account_sid = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']
      @twilio_sending_number = "+13854584096"
      @to_number = @moots_nr

      # Create an instance of the Twilio Client and authenticate with your API key
      twilio_client = Twilio::REST::Client.new(account_sid, auth_token)

      # Craft your SMS as a Hash literal with three keys
      sms_info = {
        :from => @twilio_sending_number,
        :to => @to_number,
        :body => "someone you follow just posted an ootd" 
      }

      # Send your SMS!
        twilio_client.api.account.messages.create(sms_info)
        
      redirect_to("/my_closets", { :notice => "My closet created successfully." })
    else
      redirect_to("/my_closets", { :alert => the_my_closet.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_my_closet = MyCloset.where({ :id => the_id }).at(0)

    the_my_closet.user_id = sessions.fetch(@current_user.id)
    the_my_closet.clothing = params.fetch("query_clothing")
    the_my_closet.caption = params.fetch("query_caption")

    if the_my_closet.valid?
      the_my_closet.save
 
      redirect_to("/my_closets/#{the_my_closet.id}", { :notice => "My closet updated successfully."} )
    else
      redirect_to("/my_closets/#{the_my_closet.id}", { :alert => the_my_closet.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_my_closet = MyCloset.where({ :id => the_id }).at(0)

    the_my_closet.destroy

    redirect_to("/my_closets", { :notice => "fit deleted successfully."} )
  end

  def blackbook
    followers = MootsRequest.where(:recipient_id => @current_user.id)
    @follower_list = followers.where(:status =>true) 
    followed = MootsRequest.where(:sender_id => @current_user.id)
    @followed_list = followed.where(:status =>true)
   render( :template=>"/my_closets/blackbook.html.erb")
  end 
end
