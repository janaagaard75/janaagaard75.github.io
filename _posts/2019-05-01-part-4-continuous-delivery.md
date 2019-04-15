---
layout: post
title: "Part 4: Continuous Delivery"
published: false
---

Fourth part in the series. In this part the continuous integration pipeline is upgraded to a continuous delivery pipeline, where any code pushed to GitHub is automatically deployed to a branch environment on Azure.

Until now the code has only been running locally. Instead of creating the resources manually on Azure portal website we will create the resources programmatically using an [Azure Resource Manager template](https://docs.microsoft.com/en-us/azure/azure-resource-manager/).

```bash
#!/bin/bash

if [[ $# -eq 0 ]] ; then
  echo "Specify the name of the branch as an argument."
  echo ""
  echo "    $ create-azure-resources.sh branch-name"
  echo ""
  exit 1
fi

# Create a resource group.
resource_group_name="azure-functions-typescript-$1"
echo "Creating resource group $resource_group_name."
az group create \
  --location "northeurope" \
  --name $resource_group_name

# Create the resources.
script_folder="$( cd "$(dirname ${BASH_SOURCE[0]})"; pwd -P )"
template_file=$script_folder/azure-resources.json
now=`date +"%Y%m%d-%H%M%S"`
deployment_name="CircleCI-$now"
echo "Creating resources in resource group $resource_group_name with deployment $deployment_name."
az group deployment create \
  --mode Complete \
  --name $deployment_name \
  --resource-group $resource_group_name \
  --template-file $template_file \
  --verbose
```

## Asset Resource Management Template

```javascript
// deployment/azure-resources.json
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "variables": {
    "appInsightsName": "[concat('aft-', uniqueString(resourceGroup().id), '-appinsights')]",
    "functionAppName": "[concat('aft-', uniqueString(resourceGroup().id), '-functions')]",
    "servicePlanName": "[concat('aft-', uniqueString(resourceGroup().id), '-serviceplan')]",
    "storageAccountId": "[concat(resourceGroup().id, '/providers/', 'Microsoft.Storage/storageAccounts/', variables('storageAccountName'))]",
    "storageAccountName": "[concat('aft', uniqueString(resourceGroup().id), 'sa')]"
  },
  "resources": [
    {
      "type": "Microsoft.Web/serverfarms",
      "kind": "functionapp",
      "name": "[variables('servicePlanName')]",
      "apiVersion": "2016-09-01",
      "location": "[resourceGroup().location]",
      "properties": {
        "name": "[variables('servicePlanName')]"
      },
      "sku": {
        "name": "Y1",
        "tier": "Dynamic",
        "size": "Y1",
        "family": "Y",
        "capacity": 0
      }
    },
    {
      "type": "Microsoft.Storage/storageAccounts",
      "kind": "Storage",
      "name": "[variables('storageAccountName')]",
      "apiVersion": "2018-02-01",
      "location": "[resourceGroup().location]",
      "sku": {
        "name": "Standard_LRS",
        "tier": "Standard"
      }
    },
    {
      "type": "Microsoft.Insights/components",
      "kind": "other",
      "name": "[variables('appInsightsName')]",
      "apiVersion": "2015-05-01",
      "location": "[resourceGroup().location]",
      "properties": {
        "Application_Type": "other",
        "ApplicationId": "[variables('appInsightsName')]"
      }
    },
    {
      "type": "Microsoft.Web/sites",
      "kind": "functionapp",
      "name": "[variables('functionAppName')]",
      "apiVersion": "2016-08-01",
      "dependsOn": [
        "[resourceId('Microsoft.Web/serverfarms', variables('servicePlanName'))]",
        "[resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName'))]",
        "[resourceId('Microsoft.Insights/components', variables('appInsightsName'))]"
      ],
      "location": "[resourceGroup().location]",
      "properties": {
        "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', variables('servicePlanName'))]",
        "siteConfig": {
          "appSettings": [
            {
              "name": "APPINSIGHTS_INSTRUMENTATIONKEY",
              "value": "[reference(concat('Microsoft.Insights/components/', variables('appInsightsName'))).InstrumentationKey]"
            },
            {
              "name": "AzureWebJobsStorage",
              "value": "[concat('DefaultEndpointsProtocol=https;AccountName=', variables('storageAccountName'), ';AccountKey=', listKeys(variables('storageAccountId'),'2015-05-01-preview').key1)]"
            },
            {
              "name": "FUNCTION_APP_EDIT_MODE",
              "value": "readonly"
            },
            {
              "name": "FUNCTIONS_EXTENSION_VERSION",
              "value": "~2"
            },
            {
              "name": "FUNCTIONS_WORKER_RUNTIME",
              "value": "node"
            },
            {
              "name": "MSDEPLOY_RENAME_LOCKED_FILES",
              "value": "1"
            },
            {
              "name": "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING",
              "value": "[concat('DefaultEndpointsProtocol=https;AccountName=', variables('storageAccountName'), ';AccountKey=', listKeys(variables('storageAccountId'),'2015-05-01-preview').key1)]"
            },
            {
              "name": "WEBSITE_CONTENTSHARE",
              "value": "[concat(toLower(variables('functionAppName')), '-content')]"
            },
            {
              "name": "WEBSITE_NODE_DEFAULT_VERSION",
              "value": "10.14.1"
            }
          ],
          "ftpsState": "Disabled",
          "phpVersion": "",
          "use32BitWorkerProcess": true
        }
      }
    }
  ]
}
```

TODO: Show the full list of steps done, highlighting the new ones.

{% include figure.html
  src="/images/circleci-environment-variables.png"
  alt="Environment variables defined in CircleCI"
  caption="Define AZURE_USERNAME and AZURE_PASSWORD as environment variables in CircleCI."
%}

{% include previous-next.html
  previousHref="/blog/2019-05-01-part-3-local-test"
  previousText="Part 3: Local test"
  nextHref="/blog/2019-05-01-part-5-end-to-end-test"
  nextText="Part 5: End-to-end Test"
%}
