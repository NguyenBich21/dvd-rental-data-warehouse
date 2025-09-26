from airflow import DAG
from airflow.providers.google.cloud.operators.bigquery import BigQueryInsertJobOperator
from datetime import datetime, timedelta
import os

def get_sql_path(filename):
    dag_dir = os.path.dirname(__file__)
    sql_dir = os.path.join(dag_dir, 'sql')
    return os.path.join(sql_dir, filename)

def read_sql(filename):
    file_path = get_sql_path(filename)
    with open(file_path, 'r', encoding='utf-8') as f:
        return f.read()

default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 0,
    "retry_delay": timedelta(minutes=1),
}

with DAG(
    dag_id="build_olap_sakila_star_sequential",
    default_args=default_args,
    start_date=datetime(2024, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=["sakila", "olap", "star_schema"]
) as dag:

    dim_staff = BigQueryInsertJobOperator(
        task_id="create_dim_staff",
        configuration={
            "query": {
                "query": read_sql("dim_staff.sql"),
                "useLegacySql": False
            }
        },
        location="asia-southeast1"
    )
    dim_customer = BigQueryInsertJobOperator(
        task_id="create_dim_customer",
        configuration={
            "query": {
                "query": read_sql("dim_customer.sql"),
                "useLegacySql": False
            }
        },
        location="asia-southeast1"
    )
    dim_store = BigQueryInsertJobOperator(
        task_id="create_dim_store",
        configuration={
            "query": {
                "query": read_sql("dim_store.sql"),
                "useLegacySql": False
            }
        },
        location="asia-southeast1"
    )
    dim_film = BigQueryInsertJobOperator(
        task_id="create_dim_film",
        configuration={
            "query": {
                "query": read_sql("dim_film.sql"),
                "useLegacySql": False
            }
        },
        location="asia-southeast1"
    )
    dim_actor = BigQueryInsertJobOperator(
        task_id="create_dim_actor",
        configuration={
            "query": {
                "query": read_sql("dim_actor.sql"),
                "useLegacySql": False
            }
        },
        location="asia-southeast1"
    )
    dim_date = BigQueryInsertJobOperator(
        task_id="create_dim_date",
        configuration={
            "query": {
                "query": read_sql("dim_date.sql"),
                "useLegacySql": False
            }
        },
        location="asia-southeast1"
    )
    dim_time = BigQueryInsertJobOperator(
        task_id="create_dim_time",
        configuration={
            "query": {
                "query": read_sql("dim_time.sql"),
                "useLegacySql": False
            }
        },
        location="asia-southeast1"
    )
    bridge_film_actor = BigQueryInsertJobOperator(
        task_id="create_bridge_film_actor",
        configuration={
            "query": {
                "query": read_sql("film_to_actor_bridge.sql"),
                "useLegacySql": False
            }
        },
        location="asia-southeast1"
    )
    fact_rental = BigQueryInsertJobOperator(
        task_id="create_fact_rental",
        configuration={
            "query": {
                "query": read_sql("fact_rental.sql"),
                "useLegacySql": False
            }
        },
        location="asia-southeast1"
    )

    # Thiết lập dependency tuần tự từng task
    dim_staff >> dim_customer >> dim_store >> dim_film >> dim_actor >> dim_date >> dim_time >> bridge_film_actor >> fact_rental
