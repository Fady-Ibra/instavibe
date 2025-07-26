gcloud services enable  run.googleapis.com \
                        cloudfunctions.googleapis.com \
                        cloudbuild.googleapis.com \
                        artifactregistry.googleapis.com \
                        spanner.googleapis.com \
                        apikeys.googleapis.com \
                        iam.googleapis.com \
                        compute.googleapis.com \
                        aiplatform.googleapis.com \
                        cloudresourcemanager.googleapis.com \
                        maps-backend.googleapis.com

export PROJECT_ID=$(gcloud config get project)
export PROJECT_NUMBER=$(gcloud projects describe ${PROJECT_ID} --format="value(projectNumber)")
export SERVICE_ACCOUNT_NAME=$(gcloud compute project-info describe --format="value(defaultServiceAccount)")
export SPANNER_INSTANCE_ID="instavibe-graph-instance"
export SPANNER_DATABASE_ID="graphdb"
export GOOGLE_CLOUD_PROJECT=$(gcloud config get project)
export GOOGLE_GENAI_USE_VERTEXAI=TRUE
export GOOGLE_CLOUD_LOCATION="us-central1"

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/spanner.admin"

# Spanner Database User
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/spanner.databaseUser"

# Artifact Registry Admin
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/artifactregistry.admin"

# Cloud Build Editor
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/cloudbuild.builds.editor"

# Cloud Run Admin
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/run.admin"

# IAM Service Account User
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/iam.serviceAccountUser"

# Vertex AI User
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/aiplatform.user"

# Logging Writer (to allow writing logs)
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/logging.logWriter"


gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/logging.viewer"

export REPO_NAME="introveally-repo"
gcloud artifacts repositories create $REPO_NAME \
  --repository-format=docker \
  --location=us-central1 \
  --description="Docker repository for InstaVibe workshop"