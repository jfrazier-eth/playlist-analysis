# playlist-analysis

## Goal
* Pull and view stats about a "song a day" playlist 
    * Assumes that you have a playlist that has had songs added to it once a day for some length of time
* Learn some R

## Setup 
1. Login with your spotify account and create a spotify developer application [here](https://developer.spotify.com/)
2. Copy the client id and client secret from the application and put them in the `sample.env` file
3. Rename `sample.env` to `.env`
4. Edit the settings in the spotify developer application you just created and add `http://localhost:1410/` as a Redirect URI


## Run the program
1. Open a terminal and navigate to the root directory of this project
2. Start an interactive `R` session by running `R` in the terminal
3. Load and run the main file in the session with `source("./src/main.R")`
4. Follow the prompts in the interactive session to select a user and playlist

## Example Plot
![danceability](https://github.com/jfrazier-eth/playlist-analysis/blob/main/resources/danceability.png)
