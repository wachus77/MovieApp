# MovieApp

I used **MVVM** pattern to get rid off massive view controllers (using delegation, closures, property observers)

I created **views in code** - it’s a good approach to avoid merge conflicts (or easier to solve them) and to easily reuse part of the view

I used **Coordinators** (responsible for the navigation flow - it is easier to manage transitions)

I used **dependency injections** (to promote re-usability, testability and maintainability)

I created **Unit Tests**

I created **UI Tests** to validate the main navigation flow and the properties and state of the UI elements

I created **Snapshot Tests** to ensure that UI doesn’t change unexpectedly during code modification (for example, when label changed position on the screen)

I used **DiffableSourceData** approach which manages updates for collection view’s data and UI in a simple, efficient way

I used **Compositional layouts** for collection view, which are a declarative kind of API that allows us to build large layouts by stitching together smaller layout groups


## SCREENSHOTS:

![Alt text](https://raw.githubusercontent.com/wachus77/MovieApp/main/Screenshots/movie_list.png "Movie List screen")

![Alt text](https://raw.githubusercontent.com/wachus77/MovieApp/main/Screenshots/movie_details_1.png "Movie Details screen 1")

![Alt text](https://raw.githubusercontent.com/wachus77/MovieApp/main/Screenshots/movie_details_2.png "Movie Details screen 2")
