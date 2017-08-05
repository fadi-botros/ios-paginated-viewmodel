# ios-paginated-viewmodel
A trial to apply a simple clean architecture, a paginated list

# What it demonstrate
- A trial to implement a simple version of Clean Architecture using Objective-C language
- Every class has one responsibility
  * The repository gets data (here it is simulation)
  * The entity list saves the data in memory
  * The interactor organizes the pagination (gets previous page, next page, etc...)
  * The ViewModel observes on the entity list and calls the interactor to get data
  * The ViewController (is just a view in iOS), just observe on this ViewModel and display
- Usage of Grand Central Dispatch for thread organization

# TODO:
- Swiftify manually
- Do unit tests
