import pandas as pd
import os

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

OUTPUT_PATH = '/home/src/data/parquet'

@transformer
def transform(data, *args, **kwargs):
    
    data['date'] = pd.to_datetime(data['date']).dt.date

    if not os.path.exists(OUTPUT_PATH):
        os.makedirs(OUTPUT_PATH)

    data.to_parquet(os.path.join(OUTPUT_PATH, 'trip_data.parquet'), engine='pyarrow', index=False)
 
    return OUTPUT_PATH    
@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
