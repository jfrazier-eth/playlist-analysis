install.packages("dotenv", repos = "http://cran.wustl.edu/")
install.packages("Rspotify", repos = "http://cran.wustl.edu/")
install.packages("httpuv", repos = "http://cran.wustl.edu/")

source("./src/oauth.R")
source("./src/selectPlaylist.R")
source("./src/getPlaylistTracks.R")
source("./src/getTracksAudioFeatures.R")


main <- function() {
  user_token <- get_token()

  user_id <- readline(
    prompt =
      "Enter the username of the spotify user to get playlists for: "
  )

  user <- getUser(user_id = user_id, token = user_token)
  display_name <- user$display_name
  print(paste("Welcome", display_name))

  selected_playlist <- select_playlist(
    user_id = user_id, user_token = user_token
  )

  tracks <- get_playlist_tracks(
    user_token = user_token,
    owner_id = selected_playlist$owner_id, playlist_id = selected_playlist$id
  )

  audio_features <- get_tracks_audio_features(
    ids = tracks$id, token = user_token
  )
  num_rows <- dim(audio_features)[1]
  print(paste("Found:", num_rows, "audio features"))

  print(summary(tracks))
  print(summary(audio_features))

  tracks <- merge(tracks, audio_features, by = "id")

  print(summary(tracks))

  plot(
    tracks$danceability,
    type = "o",
    xlab = "Day",
    ylab = "Danceability",
    main = "Danceability over time"
  )
}


main()
