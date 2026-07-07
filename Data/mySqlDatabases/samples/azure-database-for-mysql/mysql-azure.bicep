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

@description('MySQL server version.')
param version string

resource database 'Radius.Data/mySqlDatabases@2025-08-01-preview' = {
  name: 'mysql'
  properties: {
    application: application
    environment: environment
    secretName: dbCredentials.name
    version: version
  }
}

resource dbCredentials 'Radius.Security/secrets@2025-08-01-preview' = {
  name: 'db-creds'
  properties: {
    environment: environment
    application: application
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
