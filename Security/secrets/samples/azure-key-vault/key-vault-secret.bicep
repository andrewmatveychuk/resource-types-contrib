extension radius

@description('The Radius Application ID. Injected automatically by the rad CLI.')
param application string

@description('The env ID of your Radius Environment. Set automatically by the rad CLI.')
param environment string

@description('MySQL username.')
@secure()
param username string

@description('MySQL user password.')
@secure()
param password string

resource dbCredentials 'Radius.Security/secrets@2025-08-01-preview' = {
  name: 'db-creds'
  properties: {
    application: application
    environment: environment
    data: {
      USERNAME: {
        value: username
      }
      PASSWORD: {
        value: password
      }
    }
  }
}

resource database 'Radius.Data/mySqlDatabases@2025-08-01-preview' = {
  name: 'mysql'
  properties: {
    application: application
    environment: environment
    secretName: dbCredentials.name
    version: '8.4'
  }
}
