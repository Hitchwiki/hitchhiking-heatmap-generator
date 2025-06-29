Calculates heatmap of world-wide hitchhiking waiting times using data from https://hitchmap.com/.

The calculated map is stored at

The map can be seen e.g. at https://hitchhiking.org/

# Deployment

Currently this archiver is deployed by @tillwenke on Azure like this:

Get an Azure account with a Subscription and create the resource group `hitchhiking-data`. Then run the following from terminal:

az login       

az acr create --name crhitchhiking --resource-group hitchhiking-data --sku Basic

az acr login --name crhitchhiking  

docker build -t crhitchhiking.azurecr.io/dumpstermap-huggingface-uploader:v4 .

docker push dumpstermap.azurecr.io/dumpstermap-huggingface-uploader:v4

create an Azure Container App Jobs

- set env var HF_TOKEN with write permissions
