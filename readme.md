# VXT PoP Dashboard for Analytics

This document describes how to setup a simple VXT PoP (Proof of Play) Analytics dashboard with Grafana

For this guide, basic understanding of docker compose is needed and not part of this guide.

## Scope

This guide sets up a complete stack with

- Grafana
- PostgreSQL
- ingest tool

### Grafana

provides simple dashboards for Analytics. Dashboards are provisioned read only. They can be modified ba creating a local copy "Save as"

### PostgreSQL

Relational DB in which all datasets from the CSV files are imported

### Ingest tool

Watches a csv-files folder for new Pop CSV file, then automatically processes them one-by-one untill all data are in the Postgres DB
Processed files are moved into another folder. They have to be manually deleted once the data is verified.

## How to start

1. Clone the following github repository on a local folder like `/scripts`

```
git clone https://github.com/SESGPreSales/VXT_POP_Grafana.git
```

then cd into the newly created folder

```
cd VXT_POP_Grafana
```

You should see these folder and files:

<img width="107" height="122" alt="image" src="https://github.com/user-attachments/assets/a50840dc-9409-4e3c-94fe-a4e9542d577d" />


- csv_files
  - Place your csv files in here. This filder is watched all the time and the files are going to be processed in the next seconds. Just wait...
- init-db
  - Nothing to do with this folder and file. This is used only to create the DB structure once as we use the official postgres image (version 16)
- processed
  - processed files are copied here. they will stay here until you delete them.
- docker-compose.yml

2. Start the docker compose containers

```
docker compose up -d
```

this will pull all needed images from docker hub, then start the containers.

3. Open a browser window and point it to: `http://localhost:3007`

## How to use

1. Login to grafana using default created admin user (`admin` / `admin`). You are now forced to change th admin password. The new password will persist container restarts.
1. Click on `Dashboards` in the left navigation
1. Click on `01 Play Overview`

<img width="430" height="203" alt="image" src="https://github.com/user-attachments/assets/40e7cbeb-3ae3-4b9a-b241-24cb6515c672" />

If you already have some processed data, you should already see something now. If you should have data but nothing is shown, check for the date selector on the top right.
