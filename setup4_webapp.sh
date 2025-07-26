. set_env.sh

cd instavibe/
export IMAGE_TAG="latest"
export APP_FOLDER_NAME="instavibe"
export IMAGE_NAME="instavibe-webapp"
export IMAGE_PATH="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:${IMAGE_TAG}"
export SERVICE_NAME="instavibe"

gcloud builds submit . \
  --tag=${IMAGE_PATH} \
  --project=${PROJECT_ID}

gcloud run deploy ${SERVICE_NAME} \
  --image=${IMAGE_PATH} \
  --platform=managed \
  --region=${REGION} \
  --allow-unauthenticated \
  --set-env-vars="SPANNER_INSTANCE_ID=${SPANNER_INSTANCE_ID}" \
  --set-env-vars="SPANNER_DATABASE_ID=${SPANNER_DATABASE_ID}" \
  --set-env-vars="APP_HOST=0.0.0.0" \
  --set-env-vars="APP_PORT=8080" \
  --set-env-vars="GOOGLE_CLOUD_LOCATION=${REGION}" \
  --set-env-vars="GOOGLE_CLOUD_PROJECT=${PROJECT_ID}" \
  --set-env-vars="GOOGLE_MAPS_API_KEY=${GOOGLE_MAPS_API_KEY}" \
  --project=${PROJECT_ID} \
  --min-instances=1
