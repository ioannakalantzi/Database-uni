import csv
import json
import re

temp1 = re.compile(r"\\xa0")
temp2 = re.compile(r'\"\"')
temp3 = re.compile(r"\'([^\'\"]*)\'(: (?:\"[^\"]+\"))?")

keyword_list = {}
haskeyword_list = []

with open(r'keywords.csv', encoding='utf-8') as file:
    header = file.readline()
    reader = csv.reader(file)
    
    for i, row in enumerate(reader):
        movieid = row[0]
        keywordslist = row[1]
            
        x1 = temp1.sub(r" ", keywordslist)
        x2 = temp2.sub(r"\"", x1)
        x3 = temp3.sub(r'"\1"\2', x2)
        
        tmp = json.loads(x3)
        
        for id in tmp:
            key_id = id.get('id')
            name = id.get('name')
            
            keyword_list[key_id] = name
            header_keyword = ['id', 'name']
            
            haskeyword_list.append((movieid, key_id))
            header_haskeyword = ['movie_id', 'key_id']
                

with open(r'keyword.csv', 'w', encoding='utf-8') as new_file:
    writer = csv.writer(new_file)
    writer.writerow(header_keyword) 
    
    for row in keyword_list.items():
        writer.writerow(row) 
    
new_file.close()                         
                
with open(r'haskeyword.csv', 'w', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(header_haskeyword)
    writer.writerows(haskeyword_list)
    
f.close()
file.close()
