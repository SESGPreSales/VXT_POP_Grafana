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

<img width="275" height="115" alt="image" src="https://github.com/user-attachments/assets/11d67339-6d4f-483a-9b25-39a24adbea3e" />

3. Open a browser window and point it to: `http://localhost:3007`

<img width="216" height="209" alt="image" src="https://github.com/user-attachments/assets/8a3b975d-7731-41fe-b2a4-611e2d1c3e2b" />


## How to use

1. Login to grafana using default created admin user (`admin` / `admin`). You are now forced to change th admin password. The new password will persist container restarts.
1. Click on `Dashboards` in the left navigation
1. Click on `01 Play Overview`

<img width="430" height="203" alt="image" src="https://github.com/user-attachments/assets/40e7cbeb-3ae3-4b9a-b241-24cb6515c672" />
If you haven't added any csv before, your dashboard will be empty
<img width="857" height="396" alt="image" src="https://github.com/user-attachments/assets/d05fa396-ceff-485f-8547-2968e752b111" />

Add csv files to the `csv_files` folder
<img width="1088" height="408" alt="20260415-2010-21 6211124" src="https://github.com/user-attachments/assets/c9b85ca3-6ed3-4597-b01e-8bf0037d4885" />
wait a moment, the data is ingested automatically

> [!NOTE]
> Check the date selector on the top right... your exported data might be outside of the date range, then nothing is displayed.

If you already have some processed data, you should already see something now. 

Clicking on the colored bar of a content play visualization, or on a device content count, allows you to move to a detailed summary about that one content or device 
<img width="390" height="157" alt="image" src="https://github.com/user-attachments/assets/2536935a-e9f5-4e4a-8ef9-bad15cf54994" />
