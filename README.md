# OpenAperture.ManagerApi

This repository contains an Elixir API library for the OpenAperture Manager.

[![Build Status](https://semaphoreci.com/api/v1/projects/21ae3b0c-3c31-4fbd-b0e2-7a4c737ada50/394630/badge.svg)](https://semaphoreci.com/perceptive/openaperture_manager_api)

## Usage
Add the following to your mix.exs dependencies:

```elixir
defp deps do
  [
    {:openaperture_manager_api, "~> 0.0.1"},
  ]
end
```

This API library can be consumed either as an application (which can be supervised), or on a per-instance basis. 

### Usage:  As an Application
To use an application, add  the :openaperture_manager_api to your mix file, and specify the following configuration:

```elixir
# Configuration for the OTP application
#
# Type `mix help compile.app` for more information
def application do
  [
    mod: {MyApp, []},
    applications: [:openaperture_manager_api]
  ]
end
```

* Manager URL
  * Type: String
  * Description: The url of the OpenAperture Manager
  * Environment Configuration (.exs): :openaperture_manager_api, :manager_url
* OAuth Login URL
  * Type: String
  * Description: The login url of the OAuth2 server
  * Environment Configuration (.exs): :openaperture_manager_api, :oauth_login_url
* OAuth Client ID
  * Type: String
  * Description: The OAuth2 client id to be used for authenticating with the OpenAperture Manager
  * Environment Configuration (.exs): :openaperture_manager_api, :oauth_client_id
* OAuth Client Secret
  * Type: String
  * Description: The OAuth2 client secret to be used for authenticating with the OpenAperture Manager
  * Environment Configuration (.exs): :openaperture_manager_api, :oauth_client_secret

When using as an application, you do not need to create or specify the API Agent (it will be populated for you).

### Usage:  On a Per-Instance Basis
To use on a per-instance basis, simply create an ManagerApi process and pass it to the API modules. 

```iex
    api = OpenAperture.ManagerApi.create!(%{manager_url: "https://openaperture-mgr.host.co", oauth_login_url: "https://auth.host.co", oauth_client_id: "id", oauth_client_secret: "secret"})

```

### API Modules
The following API modules are available:

* OpenAperture.ManagerApi.MessagingBroker
  * This module is used to interact with the MessagingBroker resource (/messaging/brokers) and MessagingBrokerConnection resource (/messaging/brokers/:id/connections).
  * Get All Brokers
  	* list - returns a OpenAperture.ManagerApi.Response
  	* list! - returns a list of Maps, representing MessagingBrokers
```elixir
brokers = OpenAperture.ManagerApi.MessagingBroker.list!(api)
```
  * Get Broker
    * get_broker - returns a OpenAperture.ManagerApi.Response
    * get_broker! - returns a Map, representing MessagingBroker
```elixir
broker = OpenAperture.ManagerApi.MessagingBroker.get_broker!(api)
```
  * Create a Broker
    * create_broker - returns a OpenAperture.ManagerApi.Response
    * create_broker! - returns an identifier of the new broker
```elixir
broker_id = OpenAperture.ManagerApi.MessagingBroker.create_broker!(api, %{})
```
  * Update a Broker
    * update_broker - returns a OpenAperture.ManagerApi.Response
    * update_broker! - returns an identifier of the updated broker
```elixir
broker_id = OpenAperture.ManagerApi.MessagingBroker.update_broker!(api, 1, %{})
```
  * Delete a Broker
    * delete_broker - returns a OpenAperture.ManagerApi.Response
    * delete_broker! - returns a boolean
```elixir
OpenAperture.ManagerApi.MessagingBroker.delete_broker!(api, 1)
```
  * Create a BrokerConnection
    * create_broker_connection - returns a OpenAperture.ManagerApi.Response
    * create_broker_connection! - returns a boolean
```elixir
OpenAperture.ManagerApi.MessagingBroker.create_broker_connection!(api, 1, %{})
```
  * Get BrokerConnections
    * broker_connections - returns a OpenAperture.ManagerApi.Response
    * broker_connections! - returns a List of Maps, representing broker connections
```elixir
connections = OpenAperture.ManagerApi.MessagingBroker.broker_connections!(api, 1)
```
  * Delete BrokerConnections
    * delete_broker_connections - returns a OpenAperture.ManagerApi.Response
    * delete_broker_connections! - returns a boolean
```elixir
OpenAperture.ManagerApi.MessagingBroker.delete_broker_connections!(api, 1)
```

* OpenAperture.ManagerApi.MessagingExchange
  * This module is used to interact with the MessagingExchange resource (/messaging/exchanges) and MessagingExchangeBrokers resource (/messaging/exchanges/:id/exchanges).
  * Get All Exchanges
    * list - returns a OpenAperture.ManagerApi.Response
    * list! - returns a list of Maps, representing MessagingExchanges
```elixir
exchanges = OpenAperture.ManagerApi.MessagingExchange.list!(api)
```
  * Get Exchange
    * get_exchange - returns a OpenAperture.ManagerApi.Response
    * get_exchange! - returns a Map, representing MessagingExchange
```elixir
exchange = OpenAperture.ManagerApi.MessagingExchange.get_exchange!(api)
```
  * Create an Exchange
    * create_exchange - returns a OpenAperture.ManagerApi.Response
    * create_exchange! - returns an identifier of the new exchange
```elixir
exchange_id = OpenAperture.ManagerApi.MessagingExchange.create_exchange!(api, %{})
```
  * Update an Exchange
    * update_exchange - returns a OpenAperture.ManagerApi.Response
    * update_exchange! - returns an identifier of the updated exchange
```elixir
exchange_id = OpenAperture.ManagerApi.MessagingExchange.update_exchange!(api, 1, %{})
```
  * Delete an Exchange
    * delete_exchange - returns a OpenAperture.ManagerApi.Response
    * delete_exchange! - returns a boolean
```elixir
OpenAperture.ManagerApi.MessagingExchange.delete_exchange!(api, 1)
```
  * Create an ExchangeBroker
    * create_exchange_brokers - returns a OpenAperture.ManagerApi.Response
    * create_exchange_brokers! - returns boolean
```elixir
exchange = OpenAperture.ManagerApi.MessagingExchange.create_exchange_brokers!(api, 1, %{})
```
  * Get ExchangeBrokers
    * exchange_brokers - returns a OpenAperture.ManagerApi.Response
    * exchange_brokers! - returns a List of Maps, representing exchange brokers
```elixir
brokers = OpenAperture.ManagerApi.MessagingExchange.broker_connections!(api, 1)
```
  * Delete ExchangeBrokers
    * delete_exchange_brokers - returns a OpenAperture.ManagerApi.Response
    * delete_exchange_brokers! - returns a boolean
```elixir
OpenAperture.ManagerApi.MessagingExchange.delete_exchange_brokers!(api, 1)
```
  * Get EtcdClusters associated with the MessagingExchange
    * exchange_clusters - returns a OpenAperture.ManagerApi.Response
    * exchange_clusters! - returns a List of Maps, representing etcd clusters
```elixir
clusters = OpenAperture.ManagerApi.MessagingExchange.exchange_clusters!(api, 1)
```

* OpenAperture.ManagerApi.MessagingExchangeModule
  * This module is used to interact with the MessagingExchangeModule resource (/messaging/exchanges/:id/modules) resource.
  * Get All Modules
    * list - returns a OpenAperture.ManagerApi.Response
    * list! - returns a list of Maps, representing MessagingExchangeModules
```elixir
modules = OpenAperture.ManagerApi.MessagingExchangeModule.list!(api, 1, "123abc")
```
  * Get Module
    * get_module - returns a OpenAperture.ManagerApi.Response
    * get_module! - returns a Map, representing MessagingExchangeModule
```elixir
module = OpenAperture.ManagerApi.MessagingExchangeModule.get_module!(api, 1, "123abc")
```
  * Create an Module
    * create_module - returns a OpenAperture.ManagerApi.Response
    * create_module! - returns an identifier of the new module
```elixir
module_id = OpenAperture.ManagerApi.MessagingExchangeModule.create_module!(api, 1, "123abc", %{})
```
  * Delete an Module
    * delete_module - returns a OpenAperture.ManagerApi.Response
    * delete_module! - returns a boolean
```elixir
OpenAperture.ManagerApi.MessagingExchangeModule.delete_module!(api, 1, "123abc")
```

* OpenAperture.ManagerApi.EtcdCluster
  * This module is used to interact with the EtcdCluster resource (/clusters).
  * Get All Clusters
    * list - returns a OpenAperture.ManagerApi.Response
    * list! - returns a list of Maps, representing EtcdClusters
```elixir
clusters = OpenAperture.ManagerApi.EtcdCluster.list!(api)
```
  * Get Cluster
    * get_cluster - returns a OpenAperture.ManagerApi.Response
    * get_cluster! - returns a Map, representing EtcdCluster
```elixir
cluster = OpenAperture.ManagerApi.EtcdCluster.get_cluster!(api)
```
  * Create a Cluster
    * create_cluster - returns a OpenAperture.ManagerApi.Response
    * create_cluster! - returns the etcd_token of the new cluster
```elixir
token = OpenAperture.ManagerApi.EtcdCluster.create_cluster!(api, %{})
```
  * Delete a Cluster
    * delete_cluster - returns a OpenAperture.ManagerApi.Response
    * delete_cluster! - returns a boolean
```elixir
OpenAperture.ManagerApi.EtcdCluster.delete_cluster!(api, 1)
```
  * Get Cluster Products
    * get_cluster_products - returns a OpenAperture.ManagerApi.Response
    * get_cluster_products! - returns a List of Maps, each representing a product
```elixir
products = OpenAperture.ManagerApi.EtcdCluster.get_cluster_products!(api)
```
  * Get Cluster Machines
    * get_cluster_machines - returns a OpenAperture.ManagerApi.Response
    * get_cluster_machines! - returns a List of Maps, each representing a machine
```elixir
machines = OpenAperture.ManagerApi.EtcdCluster.get_cluster_machines!(api)
```
  * Get Cluster Units
    * get_cluster_units - returns a OpenAperture.ManagerApi.Response
    * get_cluster_units! - returns a List of Maps, each representing a unit
```elixir
units = OpenAperture.ManagerApi.EtcdCluster.get_cluster_units!(api)
```
  * Get Cluster Units State
    * get_cluster_units - returns a OpenAperture.ManagerApi.Response
    * get_cluster_units! - returns a List of Maps, each representing a unit state
```elixir
states = OpenAperture.ManagerApi.EtcdCluster.get_cluster_units!(api)
```
  * Get Cluster Unit Log
    * get_cluster_unit_log - returns a OpenAperture.ManagerApi.Response
    * get_cluster_unit_log! - returns the text of the log
```elixir
contents = OpenAperture.ManagerApi.EtcdCluster.get_cluster_unit_log!(api, "123abc", 1, "testUnit")
```

* OpenAperture.ManagerApi.Workflow
  * This module is used to interact with the Workflow resource (/workflows).
  * Get All Workflows
    * list - returns a OpenAperture.ManagerApi.Response
    * list! - returns a list of Maps, representing Workflow
```elixir
workflows = OpenAperture.ManagerApi.Workflow.list!(api)
```
  * Get Workflow
    * get_workflow - returns a OpenAperture.ManagerApi.Response
    * get_workflow! - returns a Map, representing Workflow
```elixir
workflow = OpenAperture.ManagerApi.Workflow.get_workflow!(api)
```
  * Create a Workflow
    * create_workflow - returns a OpenAperture.ManagerApi.Response
    * create_workflow! - returns the etcd_token of the new Workflow
```elixir
token = OpenAperture.ManagerApi.Workflow.create_workflow!(api, %{})
```
  * Update a Workflow
    * update_workflow - returns a OpenAperture.ManagerApi.Response
    * update_workflow! - returns an identifier of the updated Workflow
```elixir
OpenAperture.ManagerApi.Workflow.delete_workflow!(api, 1)
```
  * Delete a Workflow
    * delete_workflow - returns a OpenAperture.ManagerApi.Response
    * delete_workflow! - returns a boolean
```elixir
OpenAperture.ManagerApi.Workflow.delete_workflow!(api, 1)
```

* OpenAperture.ManagerApi.SytemComponent
  * This module is used to interact with the SytemComponent resource (/system_components).
  * Get All SytemComponents
    * list - returns a OpenAperture.ManagerApi.Response
    * list! - returns a list of Maps, representing SytemComponent
```elixir
system_components = OpenAperture.ManagerApi.SytemComponent.list!(api)
```
  * Get SytemComponent
    * get_system_component - returns a OpenAperture.ManagerApi.Response
    * get_system_component! - returns a Map, representing SytemComponent
```elixir
system_component = OpenAperture.ManagerApi.SytemComponent.get_system_component!(api)
```
  * Create a SytemComponent
    * create_system_component - returns a OpenAperture.ManagerApi.Response
    * create_system_component! - returns the etcd_token of the new SytemComponent
```elixir
token = OpenAperture.ManagerApi.SytemComponent.create_system_component!(api, %{})
```
  * Update a SystemComponent
    * update_system_component - returns a OpenAperture.ManagerApi.Response
    * update_system_component! - returns an identifier of the updated SytemComponent
```elixir
OpenAperture.ManagerApi.SytemComponent.delete_system_component!(api, 1)
```
  * Delete a SytemComponent
    * delete_system_component - returns a OpenAperture.ManagerApi.Response
    * delete_system_component! - returns a boolean
```elixir
OpenAperture.ManagerApi.SytemComponent.delete_system_component!(api, 1)
```

* OpenAperture.ManagerApi.SytemComponentRef
  * This module is used to interact with the SytemComponentRef resource (/system_component_refs).
  * Get All SytemComponentRefs
    * list - returns a OpenAperture.ManagerApi.Response
    * list! - returns a list of Maps, representing SytemComponentRef
```elixir
system_components = OpenAperture.ManagerApi.SytemComponentRef.list!(api)
```
  * Get SytemComponentRef
    * get_system_component_ref - returns a OpenAperture.ManagerApi.Response
    * get_system_component_ref! - returns a Map, representing SytemComponentRef
```elixir
system_component = OpenAperture.ManagerApi.SytemComponentRef.get_system_component_ref!(api)
```
  * Create a SytemComponentRef
    * create_system_component_ref - returns a OpenAperture.ManagerApi.Response
    * create_system_component_ref! - returns the etcd_token of the new SytemComponentRef
```elixir
token = OpenAperture.ManagerApi.SytemComponentRef.create_system_component!(api, %{})
```
  * Update a SystemComponent
    * update_system_component_ref - returns a OpenAperture.ManagerApi.Response
    * update_system_component_ref! - returns an identifier of the updated SytemComponentRef
```elixir
OpenAperture.ManagerApi.SytemComponentRef.delete_system_component_ref!(api, 1)
```
  * Delete a SytemComponentRef
    * delete_system_component - returns a OpenAperture.ManagerApi.Response
    * delete_system_component! - returns a boolean
```elixir
OpenAperture.ManagerApi.SytemComponentRef.delete_system_component_ref!(api, 1)
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
