## Book My Show

This is a movie app to showcase movie list, movie details so that user can book the movie of his choice.
It also gives user an option to search movie names and book movie he likes.

## Key Features

### Now Showing Screen
user can see list of movies
- used can click on book now to go to details screen

### Search Screen
user can search movie
- used search algo to search movie on first letter bases
- cached recently searched movies

### Details Screen
bouncy view with details like
- release date
- genre
- duration
- overview 
- title of movie
- image of movie

## Architecture
MVVVM
- Seperate network and domain layer for loose coupling the api call 
-  used diffable data source collection view from iOS 13 and above.


## Screenshots







## Folder Structure

#### UI

Main --> application

various components like nowShowing, movie details, search movie
components

#### Domain

Domain --> Repositories

movie list repository

#### Network

Network manager --> NetworkManager class

movie list service

## Owner name:

Raghav Sharma
