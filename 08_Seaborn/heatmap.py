# Libraries
import pandas as pd
import plotly.plotly as py
import plotly.graph_objs as go

# Read data
SA = pd.read_csv('south_amer.csv', encoding = "ISO-8859-1")

# Group by month and year
grp = SA.groupby(['imonth', 'iyear']).size().unstack().fillna(0)
grp = grp.drop(0)

months = ['January', 'February', 'March', 'April', 'May', 'June', 'July',
          'August', 'September', 'October', 'November', 'December']
z = grp.values.tolist()
z.reverse()
years = list(range(1970, 2017))


data = [
    go.Heatmap(
        z=z,
        x=years,
        y=months,
        colorscale='Viridis',
    )
]

layout = go.Layout(
    title='Attacks by Month',
    xaxis = dict(ticks=''),
    yaxis = dict(ticks='' )
)

fig = go.Figure(data=data, layout=layout)
py.iplot(fig, filename='08_heatmap')