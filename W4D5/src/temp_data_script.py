from datetime import datetime
import matplotlib.pyplot as plt
from meteostat import Point, Daily

start = datetime(2022, 8, 30)
end = datetime(2023, 8, 30)

# Amsterdam Coords
amsterdam = Point(52.3676, 4.9041)

data = Daily(amsterdam, start, end)
data = data.fetch()
data.head()

data = data.reset_index()

data = data[['time', 'tavg']]
data.to_csv('data/temperature_amst.csv', index = False)