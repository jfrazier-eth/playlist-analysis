library("Rspotify")

get_playlist_tracks <- function(user_token, owner_id, playlist_id) {
    page_size <- 100
    has_next_page <- TRUE
    offset <- 0
    tracks <- data.frame()

    while (has_next_page) {
        page <- getPlaylistSongs(owner_id, playlist_id, offset, user_token)
        index <- 1
        for (track_name in page$tracks) {
            track <- data.frame(
                track_name = track_name,
                album_id = page$album_id[index],
                track_id = page$id[index],
                popularity = page$popularity[index],
                artist = page$artist[index],
                artist_id = page$artist_id[index],
                album = page$album[index]
            )
            if (length(tracks) == 0) {
                tracks <- track
            } else {
                tracks <- rbind(tracks, track)
            }
            index <- index + 1
        }

        has_next_page <- length(page$tracks) == page_size
        offset <- dim(tracks)[1]
    }
    return(tracks)
}
