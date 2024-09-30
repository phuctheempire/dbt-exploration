{#
    This macro returns the description of the payment_type 
#}

{% macro get_payment_type_description(payment_type) -%}

    case {{ dbt.safe_cast("payment_type", api.Column.translate_type("integer")) }}  
        when 0 then 'Credit card'
        when 1 then 'Cash'
        when 2 then 'No charge'
        when 3 then 'Dispute'
        when 4 then 'Unknown'
        when 5 then 'Voided trip'
        else 'EMPTY'
    end

{%- endmacro %}