# Alert API

An alert system.

# Clone the Application

```
git clone git@github.com:Njunu-sk/Alert-System.git
```

# Set up the Application

Ruby Version

```
ruby "3.1.2"
```

Bundle Install

```
bundle install
```

Run migrations

```
bundle exec rails db:reset
```

Run spec file

```
bundle exec rspec
```

# Requirements

## All pages should be authenticated

Anoymous user trying to create an alert

![unauth_user](./images/unauth_user.png)

### Authenticate User

Sign Up a new User

![sign_up](./images/users_signup.png)

Sign In a User

![login](./images/user_login.png)

## JSON API that can create alert into a database

- Only alerts with types `["portal_opened", "portal_closed"]` should be saved in the database

![create_alert](./images/create_alert.png)

## JSON API that can list all alerts

![all_alerts](./images/list_alerts.png)

## JSON API that can list an alert

![alert](./images/show_alert.png)

