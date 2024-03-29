# Project 2 - *Flix*

**Flix** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **18** hours spent in total

## User Stories

The following **required** functionality is complete:

- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [X] User sees an error message when there's a networking error.
- [X] Movies are displayed using a CollectionView instead of a TableView.
- [X] User can search for a movie.
- [ ] All images fade in as they are loading.
- [X] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [ ] Customize the selection effect of the cell.
- [ ] Customize the navigation bar.
- [ ] Customize the UI.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. How to implement gesture recognizers to play movie trailers
2. Syntax: methods, headers, variable declarations

## Video Walkthrough

Here's a walkthrough of implemented user stories:

App icon and loading state
<img src='http://g.recordit.co/oJ6SkO69Pb.gif' title='App icon and loading state' width='' alt='Video Walkthrough' />

Scroll, pull to refresh, tap on cell for detailed view
<img src='http://g.recordit.co/MvgPqCVHrs.gif' title='Scroll, pull to refresh, tap on cell for detailed view' width='' alt='Video Walkthrough' />

Additional tab, collection view, tap poster for detailed view
<img src='http://g.recordit.co/J8Yz07YYlK.gif' title='Additional tab, collection view, tap poster for detailed view' width='' alt='Video Walkthrough' />

Search bar
<img src='http://g.recordit.co/4nRT1IvYoV.gif' title='Search bar' width='' alt='Video Walkthrough' />

Alert when no wifi
<img src='http://g.recordit.co/JWmZLAXwrF.gif' title='Alert when no wifi' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

Throught the videos, I followed along but didn't fully understand what I was typing. Adding extra features forced me to look through my code and figure out how view controllers were connected. Then I was able to comment my code with better details about how the parts communicated. Implementing the search bar was difficult, but talking through it with my pod and focusing on how my code worked helped me understand it better. I did not finish implementing the trailer feature and had a hard time using gesture recognizers. 

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
