# Libraries
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Read data
SA = pd.read_csv('south_amer.csv', encoding = "ISO-8859-1")

# Group by month and year
grp = SA.groupby(['imonth', 'iyear']).size().unstack().fillna(0)
grp = grp.drop(0)

months = ['January', 'February', 'March', 'April', 'May', 'June', 'July',
          'August', 'September', 'October', 'November', 'December']


# Plot
y = sns.heatmap(grp, yticklabels=months, cmap="YlGnBu")
plt.yticks(rotation = 0, size='x-small')
plt.xticks(rotation = 45, size='x-small')
plt.xlabel('Year')
plt.ylabel('Month')
plt.tight_layout()
plt.title('Yearly Trends in Attacks')
#plt.show()
plt.savefig('08_Seaborn.jpg')
