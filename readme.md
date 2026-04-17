# VXT PoP Dashboard for Analytics

This document describes how to set up a simple VXT PoP (Proof of Play) Analytics dashboard with Grafana

For this guide, a basic understanding of Docker Compose is needed, and is not part of this guide.

## Scope

This guide sets up a complete stack with:

- Grafana
- PostgreSQL
- ingest tool

### Grafana

provides simple dashboards for Analytics. Dashboards are provisioned read-only. They can be modified by creating a local copy "Save as."

### PostgreSQL

Relational DB in which all datasets from the CSV files are imported

### Ingest tool

Watches a CSV-files folder for new Pop CSV files, then automatically processes them one-by-one until all data is in the Postgres DB
Processed files are moved into another folder. They have to be manually deleted once the data is verified.

## How to start

1. Clone the following GitHub repository to a local folder like `/scripts.`

```
git clone https://github.com/SESGPreSales/VXT_POP_Grafana.git
```

Then cd into the newly created folder

```
cd VXT_POP_Grafana
```

You should see these folders and files:

<img width="107" height="122" alt="image" src="https://github.com/user-attachments/assets/a50840dc-9409-4e3c-94fe-a4e9542d577d" />

- csv_files
  - Place your CSV files in here. This folder is watched all the time, and the files are going to be processed in the next few seconds. Just wait...
- init-db
  - Nothing to do with this folder and file. This is used only to create the DB structure once, as we use the official PostgreSQL image (version 16)
- processed
  - processed files are copied here. They will stay here until you delete them.
- docker-compose.yml

2. Start the Docker Compose containers

```
docker compose up -d
```

This will pull all needed images from Docker Hub, then start the containers.

<img width="275" height="115" alt="image" src="https://github.com/user-attachments/assets/11d67339-6d4f-483a-9b25-39a24adbea3e" />

3. Open a browser window and point it to: `http://localhost:3007`

<img width="216" height="209" alt="image" src="https://github.com/user-attachments/assets/8a3b975d-7731-41fe-b2a4-611e2d1c3e2b" />

## How to use

1. Log in to Grafana using the default admin user (`admin` / `admin`). You are now forced to change the admin password. The new password will persist through container restarts.
1. Click on `Dashboards` in the left navigation
1. Click on `01 Play Overview.`

<img width="430" height="203" alt="image" src="https://github.com/user-attachments/assets/40e7cbeb-3ae3-4b9a-b241-24cb6515c672" />

If you haven't added any csv before, your dashboard will be empty

<img width="857" height="396" alt="image" src="https://github.com/user-attachments/assets/d05fa396-ceff-485f-8547-2968e752b111" />

Add CSV files to the `csv_files` folder

<img width="1088" height="408" alt="20260415-2010-21 6211124" src="https://github.com/user-attachments/assets/c9b85ca3-6ed3-4597-b01e-8bf0037d4885" />

Wait a moment, the data is ingested automatically

> [!NOTE]
> Check the date selector on the top right... Your exported data might be outside of the date range, so nothing is displayed.

If you already have some processed data, you should already see something now.

Clicking on the colored bar of a content play visualization, or on a device content count, allows you to move to a detailed summary about that one content or device

<img width="390" height="157" alt="image" src="https://github.com/user-attachments/assets/2536935a-e9f5-4e4a-8ef9-bad15cf54994" />

## How to modify dashboards

The created dashboards are provisioned at every container start. Means the dashboards are "read-only".

To modify a dashboard, create a copy by using
`Edit` then `Save dashboard` then `Save as copy.`

<img width="227" height="70" alt="image" src="https://github.com/user-attachments/assets/2dbe2ae4-4010-49a2-852d-030bed7dd51e" />
