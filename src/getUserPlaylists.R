library("Rspotify")

get_user_playlists <- function(user_id, user_token, on_page) {
    should_continue <- TRUE
    offset <- 0
    page_size <- 50
    while (should_continue == TRUE) {
        playlists <- getPlaylists(
            user_id = user_id,
            offset = offset,
            token = user_token
        )

        playlist_names <- playlists$name
        playlist_ids <- playlists$id
        playlist_owner_ids <- playlists$ownerid
        playlist_num_tracks <- playlists$tracks

        has_next_page <- length(playlist_names) == page_size

        result <- on_page(
            playlist_names,
            playlist_ids,
            playlist_owner_ids,
            playlist_num_tracks,
            has_next_page
        )
        requested_more <- result$request_more

        if (requested_more == FALSE) {
            result$request_more <- NULL
            return(result)
        }
        should_continue <- requested_more && has_next_page
        offset <- offset + page_size
    }

    return(NULL)
}
