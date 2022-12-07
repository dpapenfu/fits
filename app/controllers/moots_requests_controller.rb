class MootsRequestsController < ApplicationController
  def index
    matching_moots_requests = MootsRequest.all

    @list_of_moots_requests = matching_moots_requests.order({ :created_at => :desc })

    render({ :template => "moots_requests/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_moots_requests = MootsRequest.where({ :id => the_id })

    @the_moots_request = matching_moots_requests.at(0)

    render({ :template => "moots_requests/show.html.erb" })
  end

  def create
    @the_id = session.fetch(:user_id)
    the_moots_request = MootsRequest.new
    the_moots_request.sender_id = @the_id
    the_moots_request.recipient_id = params.fetch("query_recipient_id")
    followed = User.where(:id=>the_moots_request.recipient_id).first
    recip_private = followed[:private]

    if the_moots_request.valid?
      if recip_private == nil 
          the_moots_request.status = 1 
          the_moots_request.save
          redirect_to("/my_closets", { :notice => "followed" })
      else 
        the_moots_request.save
        redirect_to("/blackbook", { :notice => "Moots request created successfully." })
      end 
    else
      redirect_to("/directory", { :alert => the_moots_request.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_moots_request = MootsRequest.where({ :id => the_id }).at(0)

    the_moots_request.sender_id = params.fetch("query_sender_id")
    the_moots_request.recipient_id = params.fetch("query_recipient_id")
    the_moots_request.status = 1

    if the_moots_request.valid?
      the_moots_request.save
      redirect_to("/my_closets", { :notice => "updated"} )
    else
      redirect_to("/my_closets", { :alert => the_moots_request.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_moots_request = MootsRequest.where({ :id => the_id }).at(0)

    the_moots_request.destroy

    redirect_to("/blackbook", { :notice => "follower removed"} )
  end

  def unfollow
    an_id = params.fetch("path_id")
    the_moots_request = MootsRequest.where({ :id => an_id }).at(0)
    the_moots_request.destroy
    redirect_to("/blackbook", { :notice => "unfollowed"} )
  end
end
