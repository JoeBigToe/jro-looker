project_name: "bq_ecommerce"

remote_dependency: ga360_block {
  url: "https://github.com/looker-open-source/viz-liquid_fill_gauge-marketplace.git"
  ref: "master"
}

constant: VIS_LABEL {
  value: "Liquid Fill Gauge"
  export: override_optional
}

constant: VIS_ID {
  value: "liquid_fill_gauge-marketplace"
  export:  override_optional
}

visualization: {
  id: "@{VIS_ID}"
  url: "https://marketplace-api.looker.com/viz-dist/liquid_fill_gauge.js"
  label: "@{VIS_LABEL}"
}
