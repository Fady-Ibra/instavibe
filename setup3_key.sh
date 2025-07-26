. set_env.sh
export KEY_DISPLAY_NAME="Maps Platform API Key"

GOOGLE_MAPS_KEY_ID=$(gcloud services api-keys list \
  --project="${PROJECT_ID}" \
  --filter="displayName='${KEY_DISPLAY_NAME}'" \
  --format="value(uid)" \
  --limit=1)

GOOGLE_MAPS_API_KEY=$(gcloud services api-keys get-key-string "${GOOGLE_MAPS_KEY_ID}" \
    --project="${PROJECT_ID}" \
    --format="value(keyString)")

echo "${GOOGLE_MAPS_API_KEY}" > ~/mapkey.txt

echo "Retrieved GOOGLE_MAPS_API_KEY: ${GOOGLE_MAPS_API_KEY}"