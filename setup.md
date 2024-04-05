# REQUIREMENTS

To reproduce this project you will need:

* Google Cloud account
* Docker with docker-compose
* Git account

> [!NOTE]  
>You can use either your local machine or a virtual machine on Google Cloud. The decision to opt for a local machine was made to reduce the costs associated with cloud usage. However, if you prefer to run it on a virtual machine, please refer to the video below:

## :movie_camera: GCP Cloud VM 

### Setting up the environment on cloud VM
[![](https://markdown-videos-api.jorgenkh.no/youtube/ae-CV2KfoN0)](https://youtu.be/ae-CV2KfoN0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=14)

# SETUP GOOGLE CLOUD ACCOUNT

### Initial Setup

1. Create an account with your Google email ID 
2. Setup your first [project](https://console.cloud.google.com/) if you haven't already
    * eg. "truck-logistics", and note down the "Project ID" (we'll use this later when deploying infra with TF)
3. Create a [service account](https://console.cloud.google.com/iam-admin/serviceaccounts)
    * Add a service account name and click create and continue.
    * Grant `Viewer` role to begin with.
4. Create a service account key
    * Under 'Actions' click on the 3 dots and 'Manage Keys'
    * Click 'Add key' and 'Create new key', choose 'JSON' key type. It will download it to your local machine, move it to a safe directory.

### Setup for Access
 
1. [IAM Roles](https://cloud.google.com/storage/docs/access-control/iam-roles) for Service account:
   * Go to the *IAM* section of *IAM & Admin* https://console.cloud.google.com/iam-admin/iam
   * Click the *Edit principal* icon for your service account.
   * Add these roles in addition to *Viewer* : **Storage Admin** + **Storage Object Admin** + **BigQuery Admin**
   
2. Enable these APIs for your project:
   * https://console.cloud.google.com/apis/library/iam.googleapis.com
   * https://console.cloud.google.com/apis/library/iamcredentials.googleapis.com
   
3. Please ensure `GOOGLE_APPLICATION_CREDENTIALS` env-var is set.
   ```shell
   export GOOGLE_APPLICATION_CREDENTIALS="<path/to/your/service-account-authkeys>.json"

   # Refresh token/session, and verify authentication
   gcloud auth application-default login
   ```

# REPRODUCING THE PROJECT

### CLONE THE REPO

```bash
git clone https://github.com/dieegogutierrez/Data-Engineering-Capstone-Project.git
```

### UPDATE WITH YOUR INFORMATION

```bash
cd mage-zoomcamp
```
1. Rename file `dev.env` to simply `.env`.
2. Update the variables with your information, specially 'LOCAL_PATH_SERVICE_ACCOUNT' with the path to your local service account file and 'TF_VAR' with your cloud project information.

### RUN THE SCRIPT

```bash
./start.sh
```
1. The script will run Terraform in Docker and create the infrastructure in Google Cloud, specifically, a storage bucket and a BigQuery dataset.
2. Then, it will run the orchestrator MAGE, which will load local data, transform it, and export it to Google Cloud. Afterward, DBT will create models that will build a final table to be used on a dashboard.
3. Access the orchestrator at http://localhost:6789/ and run the pipeline by yourself.
4. After completion, it will create a table named 'trips_gross_revenue' in BigQuery, which can be used in Looker Studio to build a dashboard.
