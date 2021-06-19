## Book My Show

This is a movie app to showcase movie list, movie details so that user can book the movie of his choice.
It also gives user an option to search movie names and book movie he likes.

## Key Features

https://user-images.githubusercontent.com/53406407/122641029-4911e400-d120-11eb-8725-5ecd2dd2f689.mov



### Now Showing Screen
user can see list of movies
- used can click on book now to go to details screen

<img width="200" alt="2" src="https://user-images.githubusercontent.com/53406407/122640803-f71c8e80-d11e-11eb-9cad-daeebc1892c1.png">


### Search Screen
user can search movie
- used search algo to search movie on first letter bases
- cached recently searched movies

<img width="200" alt="3" src="https://user-images.githubusercontent.com/53406407/122640820-0996c800-d11f-11eb-9c86-f49d41b36124.png">


### Details Screen
bouncy view with details like
- release date
- genre
- duration
- overview 
- title of movie
- image of movie

<img width="200" alt="4" src="https://user-images.githubusercontent.com/53406407/122640838-1d422e80-d11f-11eb-8b6b-f0da7fad837f.png">

### Movies Reviews Screen
see reviews of your movie before booking the same
- rating
- author name
- author icon
- content
- published date of review

<img width="200" alt="5" src="https://user-images.githubusercontent.com/53406407/122640902-87f36a00-d11f-11eb-809a-11c91dcec4df.png">


### Similar Movies Screen
movies similar to selected movies
- we get an option to book the similar movies as well

<img width="200" alt="6" src="https://user-images.githubusercontent.com/53406407/122640909-93df2c00-d11f-11eb-96de-8d3dabf3b559.png">


## Architecture
MVVVM
- Seperate network and domain layer for loose coupling the api call 
-  used diffable data source collection view from iOS 13 and above.



## Folder Structure

#### UI

Main --> application

various components like nowShowing, movie details, search movie, similar movies, movies reviews
components

#### Domain

Domain --> Repositories

movie list repository

#### Network

Network manager --> NetworkManager class

movie list service

## Owner name:

Raghav Sharma
