# Texas Real Estate, Property Listings Analysis
# Nov. 10, 2019

# First I had to scrappe Zillow using Selenium to extract the most current listings at the time, I had to do this outside of jupyter and in VSCode instead since Jypyter was giving me issues running Selenium. I will do further data manipulation in here and then go on to visualize the data. The data was exported from VSCode to csv file which is then loaded on here to manipulate.

# Import Necessities

import pandas as pd
import numpy as np
import chart_studio.plotly as py
import cufflinks as cf
import plotly.graph_objs as go
import streamlit as st
import altair as alt
import re

cf.go_offline()


# Load Data from CSV

data = pd.read_csv('../Data/Texas_Listed_Properties.csv')
data = data.drop('Unnamed: 0', axis = 1)


# Creating & Cleaning Columns

data['State'] = data['Address'].apply(lambda x: re.sub('.*, ','',x))
data['Zip Code'] = data['State'].apply(lambda x: re.sub('[A-Z]{2} ','',x))
data['State'] = data['State'].apply(lambda x: re.sub(' .*','',x))
data['City'] = data['Address'].apply(lambda x: x.split(',')[1])

data['Address'] = data['Address'].apply(lambda x: re.sub(',.*','',x))

data['Property Size'] = data['Bed/Bath Count'].apply(lambda x: re.sub('[0-9] bds[0-9]{1,2}\.?[0-9]? ba([0-9]{1,2}?,)?','',x))
data['Property Size'] = data['Property Size'].apply(lambda x: re.sub('^.*ba','',x))
data['Property Size'] = data['Property Size'].apply(lambda x: re.sub('--','0',x))
data['Property Size in sqft'] = data['Property Size'].apply(lambda x: re.sub('\D','',x))

data['Bedroom Count'] = data['Bed/Bath Count'].apply(lambda x: re.sub('Studio?','',x))
data['Bedroom Count'] = data['Bedroom Count'].apply(lambda x: re.sub(' .*','',x))

data['Bathroom Count'] = data['Bed/Bath Count'].apply(lambda x: re.sub('\d bds','',x))
data['Bathroom Count'] = data['Bathroom Count'].apply(lambda x: re.sub(' .*','',x))
data['Bathroom Count'] = data['Bathroom Count'].apply(lambda x: re.sub('Studio?','',x))

data['Asking Price'] = data['Asking Price'].apply(lambda x: re.sub('\D','',x))


# Data Filtering & Column Arrangements

# Filtering
data = data[(data['Listing Type'] == 'House for sale') | (data['Listing Type'] == 'House for rent')].reset_index(drop = True)
data = data[(data['Bathroom Count'] != '--') | (data['Bedroom Count'] != '--')].reset_index(drop = True)

# Column Arrangements
data = data[['Address', 'Zip Code','City', 'State','Listing Type', 'Asking Price', 'Bedroom Count', 'Bathroom Count', 'Property Size in sqft']]


# Data Formatting & Additional Column Creation
# - Had to create an additional column here since the required columns' data types had to be changed to create the additional column 

#Data Formatting
data = data.astype({'Asking Price':'int', 'Bedroom Count':'float', 'Bathroom Count':'float', 'Property Size in sqft':'int'})

#Adding column after column formatting
data['Price/sqft'] = data['Asking Price'] / data['Property Size in sqft']

# Streamlit Visualizations

st.title('Texas Real Estate, Property Listings Analysis')

# Scatterplot

st.subheader('Relationship Between Property Size & Asking Price in Houston')

source = data[(data['City'] == ' Houston') & (data['Listing Type'].str.contains('sale'))]

scatterplot = alt.Chart(source).mark_circle().encode(
    x='Asking Price',
    y='Property Size in sqft',
    color='City',
    tooltip=['City', 'Asking Price', 'Property Size in sqft']
).interactive().configure_axis(
    grid=False
).configure_view(
    strokeWidth=0
)

st.write(scatterplot)

# Histogram

st.subheader('Bedroom Count Distribution for "For Sale" Listed Properties in Texas')

for_sale = data[data['Asking Price'] < (data['Asking Price'].quantile(.9))]
for_sale = for_sale[for_sale['Listing Type'] == 'House for sale'].pivot_table(index = ['City', 'Bedroom Count', 'Asking Price'], values = 'Price/sqft', aggfunc = 'mean')
for_sale = for_sale.reset_index()
for_sale = pd.DataFrame(for_sale['Bedroom Count'])

histogram = alt.Chart(for_sale).mark_bar().encode(
    alt.X("Bedroom Count", bin=True),
    y='count()',
).configure_axis(
    grid=False
).configure_view(
    strokeWidth=0
)

st.write(histogram)

# Boxplot
st.subheader('Houston, Dallas & San Antonio Texas: Listed Property Size Descriptive Stats in SQFT')
st.empty()

source = pd.DataFrame(data[(data['City'] == ' Houston') | (data['City'] == ' Dallas') | (data['City'] == ' San Antonio') ] )

box_plot = alt.Chart(source).mark_boxplot(size = 50).encode(
    x='City',
    y='Property Size in sqft'
).interactive().configure_axis(
    grid=False
).configure_view(
    strokeWidth=0
)

st.write(box_plot)

# Horizontal Bar Graph

st.subheader('Top 10 Texan Cities with Largest Avg. Living Space for Listed Rentals')

prop_size = data[(data['Listing Type'].str.contains('rent')) & (data['Property Size in sqft'] > 0)]
prop_size = prop_size.pivot_table(index = 'City', values = 'Property Size in sqft', aggfunc = 'mean')
prop_size = prop_size.sort_values(by = 'Property Size in sqft',ascending = False).head(10)

source = pd.DataFrame(prop_size.reset_index())

bar_graph = alt.Chart(source).mark_bar().encode(
    x='City',
    y='Property Size in sqft'
).interactive().configure_axis(
    grid=False
).configure_view(
    strokeWidth=0
)

st.write(bar_graph)
