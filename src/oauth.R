library("dotenv")
library("Rspotify")
library("httpuv")


get_token <- function() {
    load_dot_env(file = ".env")

    client_id <- Sys.getenv("CLIENT_ID")
    client_secret <- Sys.getenv("CLIENT_SECRET")

    if (client_id == "") {
        print("No CLIENT_ID found in .env file")
        q()
    }

    if (client_secret == "") {
        print("No CLIENT_SECRET found in .env file")
        q()
    }

    my_oauth <- spotifyOAuth(
        app_id = "",
        client_id = client_id, client_secret = client_secret
    )

    return(my_oauth)
}
