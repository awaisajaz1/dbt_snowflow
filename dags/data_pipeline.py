from datetime import datetime
import os

from airflow import DAG
from airflow.operators.python import PythonOperator, BranchPythonOperator
from airflow.operators.bash import BashOperator
from airflow.operators.dummy_operator import DummyOperator
from datetime import datetime


default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2020,8,1),
    'retries': 0
}

## The --profiles-dir flag in dbt specifies where to look for the profiles.yml file, which contains database connection configurations.

with DAG('snowflake_data_pipeline', default_args=default_args, schedule_interval='@once') as dag:
    task_1 = BashOperator(
        task_id='data_staging',
        bash_command='cd /opt/airflow/dbt && dbt run --models staging --profiles-dir .',
        env={
            'dbt_user': 'DBT_USER',
            'dbt_password': 'dbtuser',
            **os.environ
        },
        dag=dag
    )

    task_2 = BashOperator(
        task_id='dimension_processing',
        bash_command='cd /opt/airflow/dbt && dbt run --models dimensions --profiles-dir .',
        env={
            'dbt_user': 'DBT_USER',
            'dbt_password': 'dbtuser',
            **os.environ
        },
        dag=dag
    )

    task_3 = BashOperator(
        task_id='fact_processing',
        bash_command='cd /opt/airflow/dbt && dbt run --models facts --profiles-dir .',
        env={
            'dbt_user': 'DBT_USER',
            'dbt_password': 'dbtuser',
            **os.environ
        },
        dag=dag
    )

    task_1 >> task_2 >> task_3 # Define dependencies