# Notifications API

This is a Rails application that manages notifications with rate-limiting capabilities. It supports both HTML and JSON responses, allowing for easy integration with other services.

## Quick Start

```sh
docker-compose up --build -d
```
### Create a Notification via JSON API

```bash
curl -X POST http://localhost:3000/notifications.json -d '{"notification": {"recipient":"user@example.com", "notification_type":"status", "body":"This is a test notification."}}' -H "Content-Type: application/json" -H "Accept: application/json"

curl -H "Accept: application/json" http://localhost:3000/notifications.json

curl -H "Accept: application/json" http://localhost:3000/notifications/1.json

curl -X PUT http://localhost:3000/notifications/1.json -d '{"notification": {"body":"Updated body text"}}' -H "Content-Type: application/json" -H "Accept: application/json"
curl -X DELETE -H "Accept: application/json" http://localhost:3000/notifications/1.json
```
### Access via browser

`localhost:3000`


## Setup

### Prerequisites

- Ruby 2.7.2 (use `asdf` or any Ruby version manager)
- Rails 6.1.7.4
- SQLite (default, can be changed to PostgreSQL or MySQL)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-repo/notifications-api.git
   cd notifications-api
   ```

2. Install dependencies:

   ```bash
   bundle install
   ```

3. Set up the database:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. Start the Rails server:

   ```bash
   rails server
   ```

## Testing the JSON API

Use the following `curl` commands to interact with the API endpoints:

### Create a Notification

```bash
curl -X POST http://localhost:3000/notifications.json -d '{"notification": {"recipient":"user@example.com", "notification_type":"status", "body":"This is a test notification."}}' -H "Content-Type: application/json" -H "Accept: application/json"
```

### Get All Notifications

```bash
curl -H "Accept: application/json" http://localhost:3000/notifications.json
```

### Get a Single Notification

```bash
curl -H "Accept: application/json" http://localhost:3000/notifications/1.json
```

### Update a Notification

```bash
curl -X PUT http://localhost:3000/notifications/1.json -d '{"notification": {"body":"Updated body text"}}' -H "Content-Type: application/json" -H "Accept: application/json"
```

### Delete a Notification

```bash
curl -X DELETE -H "Accept: application/json" http://localhost:3000/notifications/1.json
```


