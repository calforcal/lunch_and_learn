# lunch_and_learn

## Welcome!
The Lunch and Learn App is built on a Service-Oriented-Architechture with the back-end built to expose API endpoints to our front-end developer team. We've exposed a number of endpoints to help our users search for cuisines by country, and then provide an opportunity for the user to learn more about that countries culture by providing videos and images about the country.

## Contributors
- Michael Callahan | [LinkedIn](https://www.linkedin.com/in/michaelcallahanjr/) | | [Github](https://github.com/calforcal) |

## Repo Installation
In your terminal run the following commands to clone the repositories:

**Backend**
          
     git clone git@github.com:calforcal/lunch_and_learn.git

**Installing the Gems Locally**

     bundle install

**Backend API Keys Needed**

- API_NINJAS_KEY: [API Ninjas](https://api-ninjas.com/api/airquality)
- EDAMAM_API_KEY: [Edamam API](https://developer.edamam.com/edamam-recipe-api)
- EDAMAM_API_ID: [Edamam API](https://developer.edamam.com/edamam-recipe-api)
- YOUTUBE_API_KEY: [YouTube API](https://developers.google.com/youtube/v3/docs/search/list)
- PEXELS_API_KEY: [Pexels](https://www.pexels.com/api/documentation/)

**Installing Figaro**

[Figaro Gem Docs](https://github.com/laserlemon/figaro)

In your terminal run:

     bundle exec figaro install

In the new file `config/application.yml`

Post your keys as they are listed above in this file, for both frontend and backend.

**Testing the Repositories**

Start up BOTH Servers (Frontend / Backend) by running the following command in each terminal:

     rails s

To run the full test suite:

     bundle exec rspec


