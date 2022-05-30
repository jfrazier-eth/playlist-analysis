

get_tracks_audio_features <- function(ids, token) {
  chunks <- list()
  for (id in ids) {
    if (length(chunks) == 0) {
      chunks <- list(c(id))
    } else {
      last_chunk <- chunks[[length(chunks)]]
      if (length(last_chunk) >= 100) {
        new_chunk <- c(id)
        chunks <- append(chunks, new_chunk)
      } else {
        updated_chunk <- append(last_chunk, id)
        chunks[[length(chunks)]] <- updated_chunk
      }
    }
  }

  get_chunk <- function(chunk) {
    joined_ids <- paste(chunk, collapse = ",")
    url <- paste0(
      "https://api.spotify.com/v1/audio-features", "?ids=",
      joined_ids
    )
    req <- httr::GET(
      url,
      httr::config(token = token)
    )
    json1 <- httr::content(req)
    json2 <- jsonlite::fromJSON(jsonlite::toJSON(json1))

    time_signature <- unlist(json2$audio_features$time_signature)
    duration <- unlist(json2$audio_features$duration_ms)
    analysis_url <- unlist(json2$audio_features$analysis_url)
    track_href <- unlist(json2$audio_features$track_href)
    id <- unlist(json2$audio_features$id)
    tempo <- unlist(json2$audio_features$tempo)
    valence <- unlist(json2$audio_features$valence)
    liveness <- unlist(json2$audio_features$liveness)
    instrumentalness <- unlist(json2$audio_features$instrumentalness)
    acousticness <- unlist(json2$audio_features$acousticness)
    speechiness <- unlist(json2$audio_features$speechiness)
    mode <- unlist(json2$audio_features$mode)
    loudness <- unlist(json2$audio_features$loudness)
    key <- unlist(json2$audio_features$key)
    energy <- unlist(json2$audio_features$energy)
    danceability <- unlist(json2$audio_features$danceability)

    audio_features <- data.frame(
      time_signature,
      duration,
      analysis_url,
      track_href,
      id,
      tempo,
      valence,
      liveness,
      instrumentalness,
      acousticness,
      speechiness,
      mode,
      loudness,
      key,
      energy,
      danceability
    )
    return(audio_features)
  }

  audio_features <- data.frame()
  for (index in seq_len(length(chunks))) {
    chunk <- chunks[[index]]
    chunk_res <- get_chunk(chunk)
    if (length(audio_features) == 0) {
      audio_features <- chunk_res
    } else {
      audio_features <- rbind(audio_features, chunk_res)
    }
  }

  return(audio_features)
}
