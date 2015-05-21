#Poker The Greatest

## Date: May 22, 2015


## Authors:

Ben Cornelis, Dan Minor, Jesse James, Peter Chen

## About

Play Some Texas Hold'Em With A Friend. Remember, one player needs to turn around when they are finished with their decision.


## Installation

Download the file

    $ git clone https://github.com/plc1127/poker


Retrieve the included Gemfile and Run the following command


    $ bundle install


#### Database setup

Run


    $ postgres

Leave Postgres running in Terminal and open a new Terminal window

NOTE IF THIS IS YOUR FIRST TIME USING POSTRGRES YOU MUST MAKE A DEFAULT DATABASE


    $ createdb $USER

Then Run


    $ Rake db:create


    $ Rake db:schema:load


#### Run the app


    $ ruby app.rb


#### Open a browswer and go to


    localhost:4567


## Make it interesting and use real money




#### Bug reports

If you discover any bugs, feel free to create an issue on GitHub. Please add as much information as
possible to help us fixing the possible bug. We also encourage you to help even more by forking and
sending us a pull request.


## License

MIT License. Copyright Ben Cornelis, Dan Minor, Jesse James, Peter Chen 2015
