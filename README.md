Flutter Task

The details of the test are mentioned below . Kindly read all the instructions and

Objective:
The aim is to build a Music App using Flutter that can provide lyrics of tracks
using third party api services.
Instructions:
1) App should be made only using bloc pattern.
2) Create Your own account at musixmatch to generate API-Key to use in
this project.
Requirements:
1) The homepage should load the list of Tracks for which the lyrics are
available in the backend with TRACK_ID. To perform this you will use
API-A stated below.
2) After loading, User can select any track. Once the user selects a track,
TRACK_ID of that particular track will be passed on to the next screen
using which API-B,C will fetch track’s details.
3) The Tracks details must be shown to the customer once the app gets the
response from the backend.
4) You must handle the case in which if the internet is not working, you will
show a message "NO INTERNET CONNECTION".
API Details:
5) API-A is used to show the list of the movies in the Home screen. You will
get TRACK_ID in return.
URL-https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782b
c7a52a41ba2fc1ef05b9cf40d7
6) API-B used in the next screen which will use the TRACK_ID to show the
track details.
URL-https://api.musixmatch.com/ws/1.1/track.get?track_id=TRACK_ID&a
pikey=2d782bc7a52a41ba2fc1ef05b9cf40d7
7) API-C is used along with API-A, To display track lyrics of the track using
TRACK_ID.
URL-https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=TRACK
_ID&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7
Please Note: You must make 2 Separate screens to perform this task, using 3
different APIs.
Optional Task:A bookmark button on the music details screen, which will save
the TRACK_IDand Track Name on the device’s local storage. You will then use
the saved information to make a third “Bookmarks” Page, where it will display
the names of the saved tracks, and clicking on them will load the music details
screen using the TRACK_IDthat was saved along with it.
Example Video:
https://drive.google.com/file/d/1h9Bt-jTTTULd1uuWcs-K9_UzJoA70NRd/view?us
p=sharing

