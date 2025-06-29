Calculates heatmap of world-wide hitchhiking waiting times using data from https://hitchmap.com/.

The calculated map is stored at https://huggingface.co/datasets/Hitchwiki/hitchhiking-heatmap.

The map can be seen e.g. at https://hitchhiking.org/ or https://hitchwiki.org/en/File:Hitchhiking_world.jpg.

# Deployment

Currently this archiver is deployed by @tillwenke on Azure like this:

Get an Azure account with a Subscription. Then run the following from terminal:

```
chomd 777 azure.sh
./azure_setup.sh
```

Copy `example.env` to `.env` and set the variables:
- HF_TOKEN with write permissions in huggingface

```
chomd 777 azure.sh
./azure_deploy.sh
```
