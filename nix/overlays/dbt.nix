final: prev: {
  # Override dbt to use Python 3.13 instead of the default Python version
  dbt = prev.dbt.override {
    python3 = prev.python313;
  };
}