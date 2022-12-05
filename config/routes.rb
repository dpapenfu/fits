Rails.application.routes.draw do

  # Routes for the My closet resource:   #MY CLOSET - the idea for my closet is for the user who is signed in to be able to keep a running log of what they have worn. RN, I am thinking about keeping this log separate from what other users can see, but I'm considering opening it up... 

  # CREATE
  get("/add_clothing", { :controller => "my_closets", :action => "new_clothing_form" })    
  post("/insert_my_closet", { :controller => "my_closets", :action => "create" })
       
  # READ
  
  get("/ootd", { :controller => "my_closets", :action => "feed" })

  get("/my_closets", { :controller => "my_closets", :action => "index" })
  
  get("/my_closets/:path_id", { :controller => "my_closets", :action => "show" })

  get("/blackbook", { :controller => "my_closets", :action => "blackbook" })
 
  # UPDATE
  
  post("/modify_my_closet/:path_id", { :controller => "my_closets", :action => "update" })
  
  # DELETE
  get("/delete_my_closet/:path_id", { :controller => "my_closets", :action => "destroy" })

  #------------------------------

  #Welcome page 

  get("/", { :controller => "user_authentication", :action=> "welcome_page"})

  # Routes for the Comment resource:

  # CREATE
  post("/insert_comment", { :controller => "comments", :action => "create" })
          
  # READ
  get("/comments", { :controller => "comments", :action => "index" })
  
  get("/comments/:path_id", { :controller => "comments", :action => "show" })
  
  # UPDATE
  
  post("/modify_comment/:path_id", { :controller => "comments", :action => "update" })
  
  # DELETE
  get("/delete_comment/:path_id", { :controller => "comments", :action => "destroy" })

  #------------------------------

  # Routes for the Moots request resource:

  # CREATE
  post("/insert_moots_request", { :controller => "moots_requests", :action => "create" })
          
  # READ
  get("/moots_requests", { :controller => "moots_requests", :action => "index" })
  
  get("/moots_requests/:path_id", { :controller => "moots_requests", :action => "show" })
  
  # UPDATE
  
  post("/modify_moots_request/:path_id", { :controller => "moots_requests", :action => "update" })
  
  # DELETE
  get("/delete_moots_request/:path_id", { :controller => "moots_requests", :action => "destroy" })

  #------------------------------

  # Routes for the Like resource:

  # CREATE
  post("/insert_like", { :controller => "likes", :action => "create" })
          
  # READ
  get("/likes", { :controller => "likes", :action => "index" })
  
  get("/likes/:path_id", { :controller => "likes", :action => "show" })
  
  # UPDATE
  
  post("/modify_like/:path_id", { :controller => "likes", :action => "update" })
  
  # DELETE
  get("/delete_like/:path_id", { :controller => "likes", :action => "destroy" })

  #------------------------------

  # Routes for the Photo resource:

  # CREATE
  get("/add_photo", { :controller => "photos", :action => "new_photo_form" }) 
  post("/insert_photo", { :controller => "photos", :action => "create" })
          
  # READ
  get("/photos", { :controller => "photos", :action => "index" })
  
  get("/photos/:path_id", { :controller => "photos", :action => "show" })

  get("/profile/:path_id", { :controller => "photos", :action => "profile" })

  get("/myfits", { :controller => "photos", :action => "myfits" })

  # UPDATE
  
  post("/modify_photo/:path_id", { :controller => "photos", :action => "update" })
  
  # DELETE
  get("/delete_photo/:path_id", { :controller => "photos", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #Settings Page
  get("/settings", {:controller=> "user_authentication", :action => "settings"})

  #Search made some good ground on this, but I decided that I would be better served taking a similar approach to the generic photogram final did. 
  get("/search", {:controller=> "user_authentication", :action => "search"})
  get("/search_results", {:controller=> "user_authentication", :action => "search_results"})

  #directory
  get("/directory", {:controller=> "user_authentication", :action => "directory"})
  #------------------------------


  
end
