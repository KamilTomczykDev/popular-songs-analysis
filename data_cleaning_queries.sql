SELECT *
FROM popular_spotify_songs;

SELECT * FROM popular_spotify_songs_staging;
INSERT INTO popular_spotify_songs_staging (track_name,
    artist_name,
    artist_count,
	released_year,
    released_month,
    released_day,
    in_spotify_playlists,
    in_spotify_charts,
    streams,
    bpm,
    `key`,
    `mode`,
    `danceability`,
    `valence`,
    `energy`,
    `acousticness`,
    `instrumentalness`,
    `liveness`,
    `speechiness`)
SELECT track_name,
    `artist(s)_name`,
    artist_count,
	released_year,
    released_month,
    released_day,
    in_spotify_playlists,
    in_spotify_charts,
    streams,
    bpm,
    `key`,
    `mode`,
    `danceability_%`,
    `valence_%`,
    `energy_%`,
    `acousticness_%`,
    `instrumentalness_%`,
    `liveness_%`,
    `speechiness_%`
FROM popular_spotify_songs
    
    
    

