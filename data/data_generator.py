import pandas as pd  # Importing pandas for data manipulation
import datetime  # Importing datetime for date operations
import random  # Importing random for generating random data

start_date = datetime.date(2020, 1, 1)  # Start date for data generation
end_date = datetime.date(2024, 3, 31)  # End date for data generation

# Generating a list of dates from start_date to end_date
dates = [start_date + datetime.timedelta(days=i) for i in range((end_date - start_date).days + 1)]
dates = [date.isoformat() for date in dates]  # Converting dates to ISO format

# Generating random drivers and customers
drivers = ['DRIVER_' + str(i) for i in range(1, 31)]
customers = ['CUSTOMER_' + str(i) for i in range(1, 11)]

hours = [round(hour / 10, 1) for hour in range(1, 181, 1)]  # Converting hours to one decimal point

km = list(range(20, 1201))  # Range of kilometers from 20 to 1200

# Generating rows and appending them to a list
rows = []

for _ in range(200000):
    row_values = {
        'date': random.choice(dates),
        'driver': random.choice(drivers),
        'customer': random.choice(customers),
        'hours': random.choice(hours),
        'km': random.choice(km),
    }
    rows.append(row_values)

# Converting the list of rows to a DataFrame
df = pd.DataFrame(rows)

# Calculating speed and filtering data based on conditions
df['speed'] = df['km'] / df['hours']
df = df[(df['speed'] > 25) & (df['speed'] < 70)]

# Dropping speed column
df.drop('speed', axis=1, inplace=True)

# Saving trip data to CSV file
df.to_csv('csv/trip_data.csv', index=False)

# Creating data for customer rates
data = {
    'customer': customers,
    'hour_city': [round(37 + i * 0.25, 2) for i in range(len(customers))],
    'hour_regular': [round(32 + i * 0.25, 2) for i in range(len(customers))],
    'hour_hy': [round(37 + i * 0.25, 2) for i in range(len(customers))],
    'fsc_city': [round(0.15 + i * 0.015, 2) for i in range(len(customers))],
    'fsc_regular': [round(0.45 + i * 0.015, 2) for i in range(len(customers))],
    'fsc_hy': [round(0.14 + i * 0.015, 2) for i in range(len(customers))],
    'hy_mileage': [round(1 + i * 0.05, 2) for i in range(len(customers))],
}

# Creating DataFrame for customer rates
df2 = pd.DataFrame(data)

# Saving customer rates data to CSV file
df2.to_csv('../mage-zoomcamp/truck_logistics/dbt/truck_logistics/seeds/customer_rates.csv', index=False)