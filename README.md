# sa-custom-roles-gcp-terraform

## Build from local machine

### Set env vars in your Shell

```shell
export PROJECT_ID={{your_project_id}}
export LOCATION={{your_location}}
export TF_STATE_BUCKET={{your_tf_state_bucket}}
export TF_STATE_PREFIX={{your_tf_state_prefix}}
```

### Plan

```shell
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config terraform-plan-modules.yaml \
    --substitutions _ENV=dev,_TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX \
    --verbosity="debug" .
```


### Apply

```shell
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config terraform-apply-modules.yaml \
    --substitutions _ENV=dev,_TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX \
    --verbosity="debug" .
```

### Destroy

```shell
gcloud builds submit \
    --project=$PROJECT_ID \
    --region=$LOCATION \
    --config terraform-destroy-modules.yaml \
    --substitutions _ENV=dev,_TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX \
    --verbosity="debug" .
```

## Build from the project hosted in a GITHUB repository

### Plan

```shell
gcloud beta builds triggers create manual \
  --region=$LOCATION \
  --name="terraform-plan-trigger" \
  --repo="https://github.com/tosun-si/sa-custom-roles-gcp-terraform" \
  --repo-type="GITHUB" \
  --branch="main" \
  --build-config="terraform-plan-modules.yaml" \
  --substitutions _ENV=dev,_TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX \
  --verbosity="debug"
```

### Apply

```shell
gcloud beta builds triggers create manual \
  --region=$LOCATION \
  --name="terraform-apply-trigger" \
  --repo="https://github.com/tosun-si/sa-custom-roles-gcp-terraform" \
  --repo-type="GITHUB" \
  --branch="main" \
  --build-config="terraform-apply-modules.yaml" \
  --substitutions _ENV=dev,_TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX \
  --verbosity="debug"
```

### Destroy

```shell
gcloud beta builds triggers create manual \
  --region=$LOCATION \
  --name="terraform-destroy-trigger" \
  --repo="https://github.com/tosun-si/sa-custom-roles-gcp-terraform" \
  --repo-type="GITHUB" \
  --branch="main" \
  --build-config="terraform-destroy-modules.yaml" \
  --substitutions _ENV=dev,_TF_STATE_BUCKET=$TF_STATE_BUCKET,_TF_STATE_PREFIX=$TF_STATE_PREFIX \
  --verbosity="debug"
```


