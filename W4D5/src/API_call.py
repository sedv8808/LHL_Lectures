import json
import requests
from config import api_info as a

measurement_data = []
all_measurements = []
error_measurements = []

key = a['key']
headers = {'x-api-key':a['key']}

for sensor in sensors_df['sensor_id']:
    page = 1
    while True:
        measurement_url = f"https://api.openaq.org/v3/sensors/{sensor}/days"
        
        measurement_params = {
            'date_from': '2022-09-01',
            'date_to': '2023-09-01',
            'limit': 10,
            'page': page
        }

        measurement_response = requests.get(measurement_url, 
                                            headers=headers, 
                                            params=measurement_params)
        try:
            measurement_data = measurement_response.json()
            print(f"Page {page} for sensor {sensor} fetched.")
            page += 1
            if not measurement_data['results']:
                print(f"No more data for sensor {sensor} on page {page}."
                      f"Moving to the next sensor.") 
                break
        except Exception as e:
            print(f"Error retrieving data for sensor {sensor} "
                  f"on page {page}: {e}")
            error_measurements.append({
                'sensor_id': sensor,
                'error': str(e),
                'url': measurement_response.url
            })
            page += 1
            continue

        for measurement in measurement_data['results']:
            try:
                all_measurements.append({
                    'sensor_id': sensor,
                    'parameter': measurement['parameter']['name'],
                    'parameter_units': measurement['parameter']['units'],
                    'value': measurement['value'],
                    'dateFrom': measurement['period']['datetimeFrom']['local'],
                    'dateTo': measurement['period']['datetimeTo']['local']
                })
            except Exception as e:
                print(f"Error processing measurement for sensor {sensor}: {e}")
                print(measurement)
                
print("All sensor data has been fetched.")

json_file_path = "data/amst_air_quality_data.json"
with open(json_file_path, 'w') as json_file:
    json.dump(all_measurements, json_file, indent=4)