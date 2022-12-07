class FitChecksController < ApplicationController
  def index
    matching_fit_checks = FitCheck.all

    @list_of_fit_checks = matching_fit_checks.order({ :created_at => :desc })

    render({ :template => "fit_checks/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_fit_checks = FitCheck.where({ :id => the_id })

    @the_fit_check = matching_fit_checks.at(0)

    render({ :template => "fit_checks/show.html.erb" })
  end

  def create
    the_fit_check = FitCheck.new
    the_fit_check.user_id = params.fetch("query_user_id")
    the_fit_check.my_closet_id = params.fetch("query_my_closet_id")
    
    if the_fit_check.valid?
      the_fit_check.save
      redirect_to("/my_closets/#{the_fit_check.my_closet_id}", { :notice => "liked" })
    else
      redirect_to("/my_closets/#{the_fit_check.my_closet_id}", { :alert => the_fit_check.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_fit_check = FitCheck.where({ :id => the_id }).at(0)

    the_fit_check.user_id = params.fetch("query_user_id")
    the_fit_check.my_closet_id = params.fetch("query_my_closet_id")

    if the_fit_check.valid?
      the_fit_check.save
      redirect_to("/my_closets/#{the_fit_check.my_closet_id}", { :notice => "Fit check updated successfully."} )
    else
      redirect_to("/my_closets/#{the_fit_check.my_closet_id}", { :alert => the_fit_check.errors.full_messages.to_sentence })
    end
  end

  def destroy
    liker = params.fetch("query_user_id")
    liked_photo = params.fetch("query_my_closet_id")
    @liked_photo_array = FitCheck.where(:my_closet_id=>liked_photo).where(:user_id=>liker).first
    the_fit_check = @liked_photo_array

    the_fit_check.destroy

    redirect_to("/my_closets/#{the_fit_check.my_closet_id}", { :notice => "unliked"} )
  end
end
