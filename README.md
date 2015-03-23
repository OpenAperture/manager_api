# CloudOS.ManagerAPI

This repository contains an Elixir API library for the CloudOS Manager.

## Usage
Add the following to your mix.exs dependencies:

```elixir
defp deps do
  [
    {:cloudos_manager_api, "~> 0.0.1"},
  ]
end
```

This API library can be consumed either as an application (which can be supervised), or on a per-instance basis. 

### Usage:  As an Application
To use an application, add  the :cloudos_manager_api to your mix file, and specify the following configuration:

```elixir
# Configuration for the OTP application
#
# Type `mix help compile.app` for more information
def application do
  [
    mod: {MyApp, []},
    applications: [:cloudos_manager_api]
  ]
end
```

* URL
  * Type: String
  * Description: The url of the CloudOS Manager
  * Environment Configuration (.exs): :cloudos_manager_api, :url
* Client ID
  * Type: String
  * Description: The OAuth2 client id to be used for authenticating with the CloudOS Manager
  * Environment Configuration (.exs): :cloudos_manager_api, :client_id
* Client Secret
  * Type: String
  * Description: The OAuth2 client secret to be used for authenticating with the CloudOS Manager
  * Environment Configuration (.exs): :cloudos_manager_api, :client_secret

When using as an application, you do not need to create or specify the API Agent (it will be populated for you).

### Usage:  On a Per-Instance Basis
To use on a per-instance basis, simply create an ManagerAPI process and pass it to the API modules. 

```iex
api = CloudOS.ManagerAPI.create!(%{url: "https://cloudos-mgr.psft.co", client_id: "id", client_secret: "secret"})
```

### API Modules
The following API modules are available:

* CloudOS.ManagerAPI.MessagingBroker
  * This module is used to interact with the MessagingBroker resource (/messaging/brokers) and MessagingBrokerConnection resource (/messaging/brokers/:id/connections).
  * Get All Brokers
  	* list - returns a CloudOS.ManagerAPI.Response
  	* list! - returns a list of Maps, representing MessagingBrokers
```elixir
brokers = CloudOS.ManagerAPI.MessagingBroker.list!(api)
```
  * Get Broker
    * get_broker - returns a CloudOS.ManagerAPI.Response
    * get_broker! - returns a Map, representing MessagingBroker
```elixir
broker = CloudOS.ManagerAPI.MessagingBroker.get_broker!(api)
```
  * Create a Broker
    * create_broker - returns a CloudOS.ManagerAPI.Response
    * create_broker! - returns an identifier of the new broker
```elixir
broker_id = CloudOS.ManagerAPI.MessagingBroker.create_broker!(api, %{})
```
  * Update a Broker
    * update_broker - returns a CloudOS.ManagerAPI.Response
    * update_broker! - returns an identifier of the updated broker
```elixir
broker_id = CloudOS.ManagerAPI.MessagingBroker.update_broker!(api, 1, %{})
```
  * Delete a Broker
    * delete_broker - returns a CloudOS.ManagerAPI.Response
    * delete_broker! - returns a boolean
```elixir
CloudOS.ManagerAPI.MessagingBroker.delete_broker!(api, 1)
```
  * Create a BrokerConnection
    * create_broker_connection - returns a CloudOS.ManagerAPI.Response
    * create_broker_connection! - returns a boolean
```elixir
CloudOS.ManagerAPI.MessagingBroker.create_broker_connection!(api, 1, %{})
```
  * Get BrokerConnections
    * broker_connections - returns a CloudOS.ManagerAPI.Response
    * broker_connections! - returns a List of Maps, representing broker connections
```elixir
connections = CloudOS.ManagerAPI.MessagingBroker.broker_connections!(api, 1)
```
  * Delete BrokerConnections
    * delete_broker_connections - returns a CloudOS.ManagerAPI.Response
    * delete_broker_connections! - returns a boolean
```elixir
CloudOS.ManagerAPI.MessagingBroker.delete_broker_connections!(api, 1)
```

* CloudOS.ManagerAPI.MessagingExchange
  * This module is used to interact with the MessagingExchange resource (/messaging/exchanges) and MessagingExchangeBrokers resource (/messaging/exchanges/:id/exchanges).
  * Get All Exchanges
    * list - returns a CloudOS.ManagerAPI.Response
    * list! - returns a list of Maps, representing MessagingExchanges
```elixir
exchanges = CloudOS.ManagerAPI.MessagingExchange.list!(api)
```
  * Get Exchange
    * get_exchange - returns a CloudOS.ManagerAPI.Response
    * get_exchange! - returns a Map, representing MessagingExchange
```elixir
exchange = CloudOS.ManagerAPI.MessagingExchange.get_exchange!(api)
```
  * Create an Exchange
    * create_exchange - returns a CloudOS.ManagerAPI.Response
    * create_exchange! - returns an identifier of the new exchange
```elixir
exchange_id = CloudOS.ManagerAPI.MessagingExchange.create_exchange!(api, %{})
```
  * Update an Exchange
    * update_exchange - returns a CloudOS.ManagerAPI.Response
    * update_exchange! - returns an identifier of the updated exchange
```elixir
exchange_id = CloudOS.ManagerAPI.MessagingExchange.update_exchange!(api, 1, %{})
```
  * Delete an Exchange
    * delete_exchange - returns a CloudOS.ManagerAPI.Response
    * delete_exchange! - returns a boolean
```elixir
CloudOS.ManagerAPI.MessagingExchange.delete_exchange!(api, 1)
```
  * Create an ExchangeBroker
    * create_exchange_brokers - returns a CloudOS.ManagerAPI.Response
    * create_exchange_brokers! - returns boolean
```elixir
exchange = CloudOS.ManagerAPI.MessagingExchange.create_exchange_brokers!(api, 1, %{})
```
  * Get ExchangeBrokers
    * exchange_brokers - returns a CloudOS.ManagerAPI.Response
    * exchange_brokers! - returns a List of Maps, representing exchange brokers
```elixir
brokers = CloudOS.ManagerAPI.MessagingExchange.broker_connections!(api, 1)
```
  * Delete ExchangeBrokers
    * delete_exchange_brokers - returns a CloudOS.ManagerAPI.Response
    * delete_exchange_brokers! - returns a boolean
```elixir
CloudOS.ManagerAPI.MessagingExchange.delete_exchange_brokers!(api, 1)
```
  * Get EtcdClusters associated with the MessagingExchange
    * exchange_clusters - returns a CloudOS.ManagerAPI.Response
    * exchange_clusters! - returns a List of Maps, representing etcd clusters
```elixir
clusters = CloudOS.ManagerAPI.MessagingExchange.exchange_clusters!(api, 1)
```

## Building & Testing

To build:

```iex
mix do deps.get, compile
```

To Run in iex:
```iex
iex -S mix run mix.exs
```

To Test:
```
mix test test/
```

or (integration tests)
```
mix test test/ --include external
```