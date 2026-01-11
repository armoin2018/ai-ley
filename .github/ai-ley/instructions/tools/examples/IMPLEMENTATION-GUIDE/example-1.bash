# Setup enterprise accounts
aws configure --profile enterprise
az login --tenant enterprise-tenant
gcloud auth login --account enterprise@company.com
vercel login --scope enterprise
doctl auth init --access-token enterprise-token
netlify login --enterprise