source("./src/getUserPlaylists.R")

select_playlist <- function(user_id, user_token) {
    selected_playlist <- get_user_playlists(
        user_id = user_id, user_token = user_token, on_page = on_page
    )
    return(selected_playlist)
}


on_page <- function(playlist_names, playlist_ids,
                    playlist_owner_ids, playlist_num_tracks,
                    has_next_page) {
    selections <- playlist_names
    get_more <- "Get more playlists"

    if (has_next_page) {
        selections <- append(selections,
            get_more,
            after = length(selections)
        )
    }

    selection <- select.list(selections, title = "Select a playlist")
    if (selection != get_more) {
        playlist_name <- selection
        index <- match(selection, playlist_names)

        playlist_id <- playlist_ids[index]
        playlist_owner_id <- playlist_owner_ids[index]
        playlist_num_tracks <- playlist_num_tracks[index]
        result <- data.frame(
            name = playlist_name,
            num_tracks = playlist_num_tracks,
            owner_id = playlist_owner_id,
            id = playlist_id,
            request_more = FALSE
        )
        return(result)
    } else {
        print(paste("Getting more playlists..."))
        result <- data.frame(
            request_more = TRUE
        )
        return(result)
    }
}
