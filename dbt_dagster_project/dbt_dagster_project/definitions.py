import os

from dagster import Definitions
from dagster_dbt import DbtCliResource
# Definitions = This is Dagster's model definition
# DbtCliResource = The plugin that enables Dagster to integrate with dbt

from .assets import dbtlearn_dbt_assets
from .constants import dbt_project_dir
from .schedules import schedules


defs = Definitions(
    assets=[dbtlearn_dbt_assets],
    schedules=schedules,
    resources={
        "dbt": DbtCliResource(project_dir=os.fspath(dbt_project_dir)),
    },
)