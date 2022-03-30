# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}

deploy_configs = YAML.load_file('./config/secrets.yml')['production']['deploys']
ENV['user'] = deploy_configs['backend_user']
ENV['server'] = deploy_configs['backend_server']

server ENV['server'], user: ENV['user'], roles: %w[app db web]
