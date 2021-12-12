## User info

This is a app to showcase basic details for the user, user can sign up or login into the app to extract user data.

## Key Features
UI -> swift-UI.
Db -> PostgreSql
Graphql -> Apollo
Graphql engine -> Hasura

### Sign Up
user can see sign in option with user name and password and email id
- used can click on sign in to create an account
- account will be stored in Postgresql once sign in is successful
<img width="350" alt="Screenshot 2021-12-12 at 15 09 32" src="https://user-images.githubusercontent.com/53406407/145719672-ea7d4f9f-350a-4328-aafa-ea1f10bf0e0b.png">


### Log In
user can log in with its user name and password.
- used can click on log in to access data for its account
- if log in is successful . data will be received in the app.
<img width="500" alt="Screenshot 2021-12-12 at 15 10 51" src="https://user-images.githubusercontent.com/53406407/145719694-95192b0c-a30c-49e1-ab59-ba6b0d407c25.png">

### Hasura Dashboard
<img width="1290" alt="Screenshot 2021-12-12 at 15 14 59" src="https://user-images.githubusercontent.com/53406407/145719774-6020099c-2682-4e17-a721-4336e66c27d2.png">

## Architecture
Swift UI + MVVM
- Seperate network and domain layer for loose coupling the api call 
-  used diffable data source collection view from iOS 13 and above.


## Folder Structure

#### Modules
- Sign In
- Log In

#### GraphQL
Queries.swift - stores all the operations generated from schema and queries and mutations (what you're actually asking for.)
Schema.json -> tells all of the possible queries and data types that are  present on server. (Basically what you can ask for.)
mutations.graphql -> sign up mutation.
queries.graphql -> log in query

#### Network
Network manager --> NetworkManager class uses apollo client to call the graph ql apis.
eg. ApolloClient(url: URL(string: "url for your graphql server"))

## Owner name:

Raghav Sharma
