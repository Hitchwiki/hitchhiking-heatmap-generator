#!/bin/bash
set -a
source .env
set +a

az monitor log-analytics workspace create \
    --resource-group hitchhiking \
    --workspace-name hitchhiking-logs

WORKSPACE_ID=$(az monitor log-analytics workspace show \
    --resource-group hitchhiking \
    --workspace-name hitchhiking-logs \
    --query customerId --output tsv)

WORKSPACE_KEY=$(az monitor log-analytics workspace get-shared-keys \
    --resource-group hitchhiking \
    --workspace-name hitchhiking-logs \
    --query primarySharedKey --output tsv)

az containerapp env create \
    --name hitchhiking-env \
    --resource-group hitchhiking \
    --location germanywestcentral \
    --logs-workspace-id $WORKSPACE_ID \
    --logs-workspace-key $WORKSPACE_KEY

# allowing general purpose workloads with more than 8GiB memory
az containerapp env workload-profile add \
  --resource-group hitchhiking \
  --name hitchhiking-env \
  --workload-profile-type D4 \
  --workload-profile-name gp-d4 \
  --min-nodes 1 \
  --max-nodes 3


REGISTRY_PASSWORD=$(az acr credential show \
  --name crhitchhiking \
  --query "passwords[0].value" \
  --output tsv)

# Job fails with less then 16 GiB memory because all data points are loaded into memory at once
az containerapp job create \
  --name heatmap-generate-job \
  --resource-group hitchhiking \
  --environment hitchhiking-env \
  --workload-profile-name gp-d4 \
  --replica-timeout 10800 \
  --replica-retry-limit 0 \
  --replica-completion-count 1 \
  --parallelism 1 \
  --trigger-type Schedule \
  --cron-expression "0 0 1 * *" \
  --image crhitchhiking.azurecr.io/hitchhiking-heatmap-generator:v1 \
  --cpu 4.0 \
  --memory 16.0Gi \
  --registry-server crhitchhiking.azurecr.io \
  --registry-username crhitchhiking \
  --registry-password "$REGISTRY_PASSWORD" \
  --env-vars HF_TOKEN="$HF_TOKEN"