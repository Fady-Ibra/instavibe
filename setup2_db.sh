source set_env.sh

gcloud spanner instances create $SPANNER_INSTANCE_ID \
  --config=regional-us-central1 \
  --description="GraphDB Instance InstaVibe" \
  --processing-units=100 \
  --edition=ENTERPRISE

gcloud spanner databases create $SPANNER_DATABASE_ID \
  --instance=$SPANNER_INSTANCE_ID \
  --database-dialect=GOOGLE_STANDARD_SQL

echo "Granting Spanner read/write access to ${SERVICE_ACCOUNT_NAME} for database ${SPANNER_DATABASE_ID}..."
gcloud spanner databases add-iam-policy-binding ${SPANNER_DATABASE_ID} \
  --instance=${SPANNER_INSTANCE_ID} \
  --member="serviceAccount:${SERVICE_ACCOUNT_NAME}" \
  --role="roles/spanner.databaseUser" \
  --project=${PROJECT_ID}

python -m venv env
source env/bin/activate
pip install -r requirements.txt
cd instavibe
python setup.py
cd ..