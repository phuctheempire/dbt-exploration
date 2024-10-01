### Source 
Used to declare where the source data needed for transformation 

### Variables:

To use variable, we use the function `{{ var('...')}}`
In the dbt_project.yml we can define:
```yml
    vars:
        variable_example: [1, 2, 3, 4, 5]
```
Or we can define directly in dbt command (dictionary ):
```cmd
    dbt build <model name> --var '{'name_var': value}'
```
More about var('...') function:
    - Attribute `default` is used to set the variable to be default if there is no variable defined
    Example: 
```    
    {% if var{'is_test_run', default=true} %}
        limit 100
    {% endif %}
```


### Testing

## Test:
Dbt testing:
    - Assumptions we make
    - Basically a select query
    - Compiled to sql that return failing records
    - Defined in yml files
    - Some basic tests:
        - Unique
        - Not null
        - Accepated values
        - Is a foreign keys to another tables
    - You can create your custom tests
# codegen module:
Dbt test is occured in the yml file ( schema ):
A good tool we can use is the codegen module ( which we use to define models in the schema )
Utilisation: A piece of code used to compile 
There a many ways of generation. More info in the website.
Exemple:
```
{% set models_to_generate = codegen.get_models(directory='staging', prefix='stg') %}
{{ codegen.generate_model_yaml(
    model_names = models_to_generate
) }}
```

# Testing:

Example:
```yml 
version: 2

sources:
  - name: staging
    database: terraform-tutorial-435313
    schema: taxy_rides_ny

    tables:
      - name: green_trips_data
      - name: yellow_trips_data


models:
  - name: stg_yellow_trips_data
    description: ""
    columns:
      - name: tripid
        data_type: string
        description: ""
        test:
          - unique: # unique test
              severity: warn
          - not_null:
              severity: warn

      - name: vendorid
        data_type: int64
        description: ""

      - name: ratecodeid
        data_type: int64
        description: ""

      - name: pickup_locationid
        data_type: int64
        description: ""
        tests:
          - relationships: # relationship test 
              field: locationid
              to: ref('dim_zones')
              severity: warn

      - name: dropoff_locationid
        data_type: int64
        description: ""

      - name: pickup_datetime
        data_type: timestamp
        description: ""

      - name: dropoff_datetime
        data_type: timestamp
        description: ""

      - name: store_and_fwd_flag
        data_type: string
        description: ""

      - name: passenger_count
        data_type: int64
        description: ""

      - name: trip_distance
        data_type: numeric
        description: ""

      - name: trip_type
        data_type: int64
        description: ""


      - name: fare_amount
        data_type: numeric
        description: ""

      - name: extra
        data_type: numeric
        description: ""

      - name: mta_tax
        data_type: numeric
        description: ""

      - name: tip_amount
        data_type: numeric
        description: ""

      - name: tolls_amount
        data_type: numeric
        description: ""

      - name: ehail_fee
        data_type: numeric
        description: ""

      - name: improvement_surcharge
        data_type: numeric
        description: ""

      - name: total_amount
        data_type: numeric
        description: ""

      - name: payment_type
        data_type: int64
        description: ""
        tests:
          - accepted_values: 
              values: "{{ var('payment_type_values')}}" 
            #   [1, 2, 3, 4, 5]
              severity: warn
              quote: false

      - name: payment_type_description
        data_type: string
        description: ""


```


### Documentation the project:

dbt provides a way to generate documentation for your dbt project and render it as a website.

The documentation for your project includes: 
- Information about your project:
    - Model code (both from the .sql file and compiled)
    - Model dependencies
    - Sources
    - Auto generated DAG from the
    - ref and source macros
    - Descriptions (from .yml file) and tests
- Information about your data warehouse (information schema):
    - Column names and data types
    - Table stats like size and rows

dbt docs can also be hosted in dbt cloud

To document the project use `dbt docs generate`, this will create a file manifest.json in the folder target and to view as web version, use `dbt docs serve`