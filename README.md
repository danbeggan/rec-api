# README

## Task approach

**Installing Gems**

I started by initializing a new rails applcation with --api flag and installing the gems I knew I would need. I installed rspec for writing tests, I would usually install factory bot alongside it but at this point I don't think I will need any models as I will just be pulling data from the recipes API. I will either use WebMock or VCR to mock the API in tests. I also installed Blueprinter for JSON serialization and HTTP party for making http requests to the MealDB API.

**Categories controller and calling the API**

The first endpoint I worked on was the categories (/api/v1/categories). I nested this in /api/v1 namespace to keep the versioning clear. I created a service object MealDB::GetCategories to call the MealDB API and return the categories which are serialized in the CategoriesBlueprint and rendered in the response. I copied the data to a json file in spec/fixtures and used Webmock to mock the endpoint so it wouldn't call the api each time the tests are run.