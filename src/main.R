source("./src/oauth.R")
source("./src/selectPlaylist.R")

# create a function that prints hello world
main <- function() {
  user_token <- get_token()

  user_id <- readline(prompt="Enter your spotify username: ")

  user <- getUser(user_id = user_id, token = user_token)
  display_name <- user$display_name

  print(paste("Welcome", display_name))

  selected_playlist <- select_playlist(
    user_id = user_id, user_token = user_token)

  print(selected_playlist)
}


main()
