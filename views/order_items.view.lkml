view: order_items {
  sql_table_name: `ecommerce.order_items` ;;
  drill_fields: [id]


  parameter: time_granularity {
    type: unquoted
    default_value: "created_month"
    allowed_value: {
      label: "Date"
      value: "created_date"
    }
    allowed_value: {
      label: "Week"
      value: "created_week"
    }
    allowed_value: {
      label: "Month"
      value: "created_month"
    }
  }

  dimension: chosen_date {
    type: string
    sql:
    {% if time_granularity._parameter_value == "created_date"  %}
      ${created_date}
    {% elsif time_granularity._parameter_value == "created_week"  %}
      ${created_week}
    {% elsif time_granularity._parameter_value == "created_month"  %}
      ${created_month}
    {% else %}
      null
    {% endif %}
    ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension_group: delivered {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.delivered_at ;;
  }
  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }
  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }
  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }
  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }
  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }
  dimension_group: shipped {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.shipped_at ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_revenue {
    type: sum
    sql: ${sale_price} ;;
    value_format:"$#.00;($#.00)"
    drill_fields: [detail*]
    link: {
      label: "Convert to PLN"
      url: "https://www.xe.com/currencyconverter/convert/?Amount={{value}}&From=USD&To=PLN"
    }
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.last_name,
  users.id,
  users.first_name,
  inventory_items.id,
  inventory_items.product_name,
  products.name,
  products.id,
  orders.order_id
  ]
  }

}
