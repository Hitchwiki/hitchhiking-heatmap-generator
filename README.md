
requires 8 GB RAM

Calculates heatmap of world-wide hitchhiking waiting times using data from https://hitchmap.com/.

The calculated map is stored at

The map can be seen e.g. at https://hitchhiking.org/

# Deployment

Currently this archiver is deployed by @tillwenke on Azure like this:

Get an Azure account with a Subscription and create the resource group `dumpstermap`. Then run the following from terminal:

az login       

az acr create --name dumpstermap --resource-group dumpstermap --sku Basic

az acr login --name dumpstermap  

(docker build -t dumpstermap-huggingface-uploader:v3 .)

docker build -t dumpstermap.azurecr.io/dumpstermap-huggingface-uploader:v4 .

(docker tag dumpstermap-huggingface-uploader:v3 dumpstermap.azurecr.io/dumpstermap-huggingface-uploader:v3)

docker push dumpstermap.azurecr.io/dumpstermap-huggingface-uploader:v4

create an Azure Container App Jobs

- set env var HF_TOKEN with write permissions