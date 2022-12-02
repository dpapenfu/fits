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
    the_moots_request = MootsRequest.new
    the_moots_request.sender_id = params.fetch("query_sender_id")
    the_moots_request.recipient_id = params.fetch("query_recipient_id")

    if the_moots_request.valid?
      the_moots_request.save
      redirect_to("/moots_requests", { :notice => "Moots request created successfully." })
    else
      redirect_to("/moots_requests", { :alert => the_moots_request.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_moots_request = MootsRequest.where({ :id => the_id }).at(0)

    the_moots_request.sender_id = params.fetch("query_sender_id")
    the_moots_request.recipient_id = params.fetch("query_recipient_id")

    if the_moots_request.valid?
      the_moots_request.save
      redirect_to("/moots_requests/#{the_moots_request.id}", { :notice => "Moots request updated successfully."} )
    else
      redirect_to("/moots_requests/#{the_moots_request.id}", { :alert => the_moots_request.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_moots_request = MootsRequest.where({ :id => the_id }).at(0)

    the_moots_request.destroy

    redirect_to("/moots_requests", { :notice => "Moots request deleted successfully."} )
  end
end
