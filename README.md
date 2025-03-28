# Event Booking System

This README provides instructions to set up and run the Event Booking System application.

## Prerequisites

- **Ruby**: Ruby version installed on my system is 2.7.6
- **Rails**: Rails version 7.1 or higher.

## Setup Instructions

 **Install Required Gems**:
   Run the following commands to install the necessary gems:
   ```sh
   gem install zeitwerk -v 2.6.18
   gem install nokogiri -v 1.15.7
   gem install securerandom -v 0.3.2
   gem install activesupport -v 7.1
   gem install net-imap -v 0.4.19
   gem install rails -v 7.1

## Database Setup
  Run the following commands to set up the database:
  rails db:create
  rails db:migrate

## Bundle gems
  Run the follwing commad:
  bundle install

## Running Sidekiq
  Run the following command:
  bundle exec sidekiq

## Running the Application
  Start the Rails server with:
  rails server
