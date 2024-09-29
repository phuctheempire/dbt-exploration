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

