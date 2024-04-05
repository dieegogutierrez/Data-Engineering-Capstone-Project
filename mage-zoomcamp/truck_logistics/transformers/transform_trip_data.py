import pandas as pd
import os

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

OUTPUT_PATH = '/home/src/data/parquet'
OUTPUT_PATH_FILE = '/home/src/data/parquet/trip_data.parquet'

@transformer
def transform(data, *args, **kwargs):
    
    data['date'] = pd.to_datetime(data['date']).dt.date

    if not os.path.exists(OUTPUT_PATH):
        os.makedirs(OUTPUT_PATH)

    data.to_parquet(OUTPUT_PATH_FILE, engine='pyarrow', index=False)
 
    return OUTPUT_PATH_FILE    
@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
import pandas as pd
import os

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

OUTPUT_PATH = '/home/src/data/parquet'
OUTPUT_PATH_FILE = '/home/src/data/parquet/trip_data.parquet'

@transformer
def transform(data, *args, **kwargs):
    
    data['date'] = pd.to_datetime(data['date']).dt.date

    if not os.path.exists(OUTPUT_PATH):
        os.makedirs(OUTPUT_PATH)

    data.to_parquet(OUTPUT_PATH_FILE, engine='pyarrow', index=False)
 
    return OUTPUT_PATH_FILE    
@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
