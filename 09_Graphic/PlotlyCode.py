# Libraries
import pandas as pd
import plotly.figure_factory as ff
import numpy as np
import plotly.plotly as py
import plotly.graph_objs as go

# Read data
SA = pd.read_csv('south_amer.csv', encoding = "ISO-8859-1")

colorscale = ['#7A4579', '#D56073', 'rgb(236,158,105)', (1, 1, 0.2), (0.98,0.98,0.98)]

t = SA['iyear']
x = SA['longitude']
y = SA['latitude']

fig = ff.create_2d_density(
    x, y, colorscale=colorscale,
    hist_color='rgb(255, 237, 222)', point_size=3)


py.iplot(fig, filename='density')