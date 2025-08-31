import requests
from bs4 import BeautifulSoup
import pandas as pd
import re

def read_urls(file_path):
    with open(file_path,'r') as file:
        urls = file.read().splitlines()
    return urls
def extract_school_names(url_list):
    pattern=re.compile(r'/schools/([^/]+)/')
    school_names = [pattern.search(url).group(1) for url in url_list]
    return school_names
def get_specific_table(url):
    response=requests.get(url)
    
    soup=BeautifulSoup(response.content,'html.parser')
    tables=soup.find_all('table')

    for table in tables:
        if table.find('tr'):
            first_row= table.find('tr')
            if first_row.find('th') and first_row.find('th').get_text().strip().endswith('G'):
                
                rows=table.find_all('tr')
                data=[]

                for row in rows:
                    cols = row.find_all('td')
                    cols=[ele.text.strip() for ele in cols]
                    data.append(cols)
                data=[row for row in data if any(row)]
                return(data)

def main():
    
    # read text file(the one we are going to make)
    file_path='cfb_all_teams2024.txt'
    url_list= read_urls(file_path)
    school_names=extract_school_names(url_list)
    for i in range(0,len(url_list)):
        specific_table=get_specific_table(url_list[i])
        headers=['Date','Time','Day','School','','Opponent','Conf','','Pts','Opp','W','L','Streak','Notes']

        df=pd.DataFrame(specific_table)
    
        df.columns=headers

        df.to_csv(school_names[i]+'2024.csv',index=False)

main()
