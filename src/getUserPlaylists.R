install.packages("Rspotify", repos = "http://cran.wustl.edu/")
library("Rspotify")

get_user_playlists <- function(user_id, user_token) {
    user_selected_playlist <- FALSE
    offset <- 0
    page_size <- 50
    while (user_selected_playlist != TRUE) {
        playlists <- getPlaylists(
            user_id = user_id,
            offset = offset,
            token = user_token
        )

        playlist_names <- playlists$name
        playlist_ids <- playlists$id
        playlist_owner_ids <- playlists$ownerid
        playlist_num_tracks <- playlists$tracks

        selections <- playlist_names
        get_more <- "Get more playlists"
        has_next_page <- length(playlist_names) == page_size

        print(playlists)

        if (has_next_page) {
            selections <- append(selections,
                get_more,
                after = length(selections)
            )
        }
        # playlists = name, id, ownerid, tracks (number of tracks)
        selection <- select.list(selections, title = "Select a playlist")
        if (selection != get_more) {
            playlist_name <- selection
            index <- match(selection, playlist_names)

            playlist_id <- playlist_ids[index]
            playlist_owner_id <- playlist_owner_ids[index]
            playlist_num_tracks <- playlist_num_tracks[index]
            user_selected_playlist <- TRUE
            print(paste(
                "You selected", playlist_name,
                "Owner:", playlist_owner_id,
                "Number of tracks:", playlist_num_tracks,
                "ID:", playlist_id
            ))
            return(playlist_id)
        } else {
            offset <- offset + length(playlist_names)
            print(paste("Getting more playlists...", offset))
        }
    }
}
