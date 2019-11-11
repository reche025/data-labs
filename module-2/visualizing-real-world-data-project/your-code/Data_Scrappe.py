
from selenium import webdriver
import pandas as pd
import time
import random

driver = webdriver.Chrome()

data = []

for i in range(1, 21):
    # time.sleep(random.choice([1,2,3,4,5]))
    driver.get(f'https://www.zillow.com/homes/Texas_rb/{i}_p/')
    get_prices = driver.find_elements_by_xpath('//article[@class="list-card list-card-short list-card_not-saved"]')
    items = [item.text for item in get_prices]
    data.append(items)
    
info = []   

for lsts in data:
    for lst in lsts:
        info.append(lst)

driver.close()

raw_data = pd.DataFrame(info)

raw_data['split'] = raw_data[0].apply(lambda x: x.split('\n'))
raw_data['Address'] = [address[0] for address in raw_data['split']]
raw_data['Listing Type'] = [address[1] for address in raw_data['split']]
raw_data['Asking Price'] = [address[2] for address in raw_data['split']]
raw_data['Bed/Bath Count'] = [address[3] for address in raw_data['split']]

clean_data = raw_data[['Address', 'Listing Type', 'Asking Price', 'Bed/Bath Count']]

print(info)

clean_data.to_csv('/Users/rayechevarria/documents/ironhack/data-labs/module-2/visualizing-real-world-data-project/Data/Texas_Listed_Properties2.csv')
