import pyodbc
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

server = 'mysqlserverodio.database.windows.net'
database = 'ExercisesDatabase'
username = 'examiner'
password = 'passwordOdio123!@#'

cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)

cursor = cnxn.cursor()

#1
cursor.execute("""SELECT subquery.year, SUM(subquery.movies_per_year) AS movies_per_year
                FROM (
                SELECT YEAR(m.release_date) AS year, COUNT(*) AS movies_per_year
                FROM movie m
                WHERE budget > 1000000
                GROUP BY release_date
                ) AS subquery
                GROUP BY subquery.year
                ORDER BY subquery.year;""")


rows = cursor.fetchall()

x_values1 = [row.year for row in rows]
y_values1 = [row.movies_per_year for row in rows]

plt.scatter(x_values1, y_values1)
plt.xlabel('Year')
plt.ylabel('Movies_per_year')
plt.title('Scatter Plot')
plt.show()

#2
cursor.execute("""SELECT g.name AS genre, COUNT(*) AS movies_per_genre
FROM movie m
JOIN hasGenre hg 
ON hg.movie_id = m.id
JOIN genre g
ON g.id = hg.genre_id
WHERE m.budget > 1000000 OR m.runtime > 120
GROUP BY hg.genre_id, g.name""")

rows = cursor.fetchall()

x_values2 = [row.genre for row in rows]
y_values2 = [row.movies_per_genre for row in rows]

plt.bar(x_values2, y_values2)
plt.xlabel('genre')
plt.ylabel('Movies_per_genre')
plt.title('Bar Plot')
plt.bar(x_values2,y_values2)
plt.show()

#3

cursor.execute("""SELECT g.name AS genre,YEAR(m.release_date) AS year, COUNT(*) AS movies_per_gy
FROM movie m
JOIN hasGenre hg 
ON hg.movie_id = m.id
JOIN genre g
ON g.id = hg.genre_id
WHERE YEAR(m.release_date) IS NOT NULL
GROUP BY g.name, YEAR(m.release_date)
ORDER BY YEAR(m.release_date)""")

rows = cursor.fetchall()

x_values3 = [row.genre for row in rows]
y_values3 = [row.year for row in rows]
z_values3 = [row.movies_per_gy for row in rows]

y_values3 = np.array(y_values3, dtype=float)
z_values3 = np.array(z_values3, dtype=float)

unique_categories = np.unique(x_values3)  
x_indices = np.arange(len(unique_categories))  

x_numeric = [x_indices[np.where(unique_categories == value)[0][0]] for value in x_values3]

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.bar3d(x_numeric, y_values3, 0, 0.8, 0.8, z_values3)
ax.set_xlabel('genre')
ax.set_ylabel('year')
ax.set_zlabel('movies_per_gy')
ax.set_xticks(x_indices)  
ax.set_xticklabels(unique_categories)  

plt.title('3D Bar Plot')
plt.show()

#4

cursor.execute("""SELECT YEAR(m.release_date) AS year, SUM(m.revenue) AS revenues_by_year
FROM movie m
JOIN movie_cast mc ON m.id = mc.movie_id
WHERE mc.name = 'Leonardo DiCaprio'
GROUP BY YEAR(m.release_date)
ORDER BY year;""")

rows = cursor.fetchall()

x_values4 = [row.year for row in rows]
y_values4 = [row.revenues_by_year for row in rows]

plt.bar(x_values4, y_values4)
plt.xlabel('year')
plt.ylabel('revenues_by_year')
plt.title('Bar Plot')
plt.bar(x_values4,y_values4)
plt.show()

#5

cursor.execute("""SELECT YEAR(m.release_date) AS year, MAX(m.budget) AS max_budget
FROM movie m
WHERE m.budget > 0
GROUP BY YEAR(m.release_date)
ORDER BY year;""")

rows = cursor.fetchall()

x_values5 = [row.year for row in rows]
y_values5 = [row.max_budget for row in rows]

plt.scatter(x_values5, y_values5)
plt.xlabel('Year')
plt.ylabel('max_budget')
plt.title('Scatter Plot')
plt.show()

#7

cursor.execute("""SELECT AVG(r.rating) AS avg_rating, COUNT(r.rating) AS rating_count
FROM ratings r
GROUP BY r.user_id;""")

rows = cursor.fetchall()

x_values7 = [row.avg_rating for row in rows]
y_values7 = [row.rating_count for row in rows]

plt.bar(x_values7, y_values7)
plt.xlabel('avg_rating')
plt.ylabel('rating_count')
plt.title('Bar Plot')
plt.bar(x_values7,y_values7)
plt.show()

