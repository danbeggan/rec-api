# RecAPI README

## Setup

The application requires Ruby 3.2.2 to be installed.

1. Run `bundle install` to install the required gems
2. Run `bundle exec rails s` to start the rails server. There is no database setup needed for this application.
3. Run the test suite using `bundle exec rspec`
4. There is also recipes.http file in the root directory which can be used to call both the application endpoints and MealDB endpoints

## Task approach

**Installing Gems**

I started by initializing a new rails application with --api flag and installing the gems I knew I would need. I installed rspec for writing tests, I would usually install factory bot alongside it but at this point I don't think I will need any models as I will just be pulling data from the recipes API. I will either use WebMock or VCR to mock the API in tests. I also installed Blueprinter for JSON serialization and HTTP party for making http requests to the MealDB API.

**Categories controller and calling the API**

The first endpoint I worked on was the categories (/api/v1/categories). I nested this in /api/v1 namespace to keep the versioning clear. I created a service object MealDB::GetCategories to call the MealDB API and return the categories which are serialized in the CategoriesBlueprint and rendered in the response. I copied the data to a json file in spec/fixtures and used Webmock to mock the endpoint so it wouldn't call the api each time the tests are run.

**Recipes controller**

I felt it didn't make sense to nest the recipes endpoints in the categories like /api/v1/categories/:id/recipes because its not possible to get the recipes from the MealDB API via the category id, only the category name. I could have made 2 calls to the API, the first to get the category name by calling the categories endpoint and filtering by the :id to get the name and then getting the recipes using the name and returning that, however, I felt that was overcomplicating things. I decided category_name could be a param in the recipes index endpoint and it would require just one call to the MealDB API.

For the recipes show endpoint I created a seperate view in the RecipeBlueprint which would include the additional fields that are not available in the index method. I decided to concatonate the measure and ingredient name fields into an ingredients array in this view. I also added an error message when a user tried to list the recipes for a category that didn't exist as I felt this was more helpful that just returning an empty list.