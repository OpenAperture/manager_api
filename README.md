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
  * This module is used to interact with the MessagingBrokers Fleet resource (/messaging/brokers).
  * Get All Brokers
  	* list - returns a CloudOS.ManagerAPI.Response
  	* list! - returns a list of Maps, representing MessagingBrokers
  	
```elixir
brokers = CloudOS.ManagerAPI.MessagingBroker.list!(api)
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