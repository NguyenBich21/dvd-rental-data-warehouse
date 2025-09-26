# 🎬 DVD Rental Store Data Warehouse

📌 **Academic Project – Data Warehouse Course**  
👥 Team project (5 members)  

---

## 📖 Project Overview
This project develops a **data warehouse** for the DVD Rental Store dataset.  
It includes two main parts:  
1. **My Work** → SQL analysis & Power BI dashboard (see [datawarehouse/](./datawarehouse))  
2. **Team Member Work** → Data warehouse design & ETL process using BigQuery, SQL, Airflow, and RAG  

---

## 🛠️ Tools & Technologies
- **Google BigQuery** – Data warehouse implementation  
- **SQL** – Dimension & fact table creation, OLAP queries  
- **Airflow** – Workflow orchestration and ETL automation  
- **RAG (Retrieval-Augmented Generation)** – Applied in query optimization/documentation support  

---

## 📂 Repository Structure

### 📁 My Contribution
┣ 📄 SQL.sql
┣ 📄 RFM.sql
┗ 📄 Final_DataWareHouse.pbix


### 📁 Data Warehouse (Team Member’s Contribution)
📁 datawarehouse
┣ 📄 dim_actor.sql
┣ 📄 dim_customer.sql
┣ 📄 dim_date.sql
┣ 📄 dim_film.sql
┣ 📄 dim_staff.sql
┣ 📄 dim_store.sql
┣ 📄 dim_time.sql
┣ 📄 fact_rental.sql
┣ 📄 film_to_actor_bridge.sql
┣ 📄 mysql_to_staging.ipynb
┗ 📄 build_olap_sakila_star_sequential.py


---

## 📊 Key Features (Team Member Work)
- **Data Warehouse Schema**: Designed **Star Schema** with multiple dimension and fact tables  
- **ETL Pipeline**: Implemented with **Airflow** and BigQuery  
- **Staging Area**: Data loading scripts (`mysql_to_staging.ipynb`)  
- **OLAP Queries**: SQL scripts for business intelligence queries  
- **Automation**: Python + Airflow DAGs for sequential ETL workflow  

---

## 👤 My Contribution
- BigQuery SQL analysis for business performance & RFM segmentation  
- Power BI dashboard (`Final_DataWareHouse.pbix`) for visualization  
- Consolidated insights into recommendations  

---

## 👥 Team Member Contribution
- Built **data warehouse schema** (dimension & fact tables)  
- Developed **ETL pipeline** (Airflow + SQL + Python)  
- Implemented **staging and OLAP layer** on BigQuery  

