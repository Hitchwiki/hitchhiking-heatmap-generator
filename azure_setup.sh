az login

az group create --name hitchhiking --location germanywestcentral

az acr create \
  --name crhitchhiking \
  --resource-group hitchhiking \
  --sku Basic \
  --admin-enabled true

az acr login --name crhitchhiking

docker build -t crhitchhiking.azurecr.io/hitchhiking-heatmap-generator:v1 ./image/

docker push crhitchhiking.azurecr.io/hitchhiking-heatmap-generator:v1
