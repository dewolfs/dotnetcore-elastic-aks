// module container registry
param acrName  string {
  default: 'acrdwe001'
  metadata: {
    description: 'Specifies the name of the azure container registry.'
  }
}

param acrLocation string  {
  default: resourceGroup().location
  metadata: {
    description: 'Location of the virtual network'
  }
}

param acrAdminUserEnabled bool {
  default: false
  metadata: {
    description: 'Enable admin user that have push / pull permission to the registry.'
  }
}

param acrSku string {
  default: 'Basic'
  allowed: [
    'Basic'
    'Standard'
    'Premium'
  ]
  metadata: {
    'description': 'Tier of your Azure Container Registry.'
  }
}

// azure container registry
resource acr 'Microsoft.ContainerRegistry/registries@2019-12-01-preview' = {
  name: acrName
  location: acrLocation
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: acrAdminUserEnabled
  }
}


output acrLoginServer string = acr.properties.loginServer