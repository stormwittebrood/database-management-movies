This environment contains both the database implementation in SQL and the Python encapsulator for retrieving the SQL database in Python.

The purpose of this project was to determine the relevance of movie characteristics with their box office performance.
It combines movie characteristics, production-related information, expert reviews, user reviews and box-office data.

The database is structured according to the ERD which is visible in the group report. SQL is used to clean, normalize and connect the different datasets.
Python is used to extract information from SQL and create dataframes that are suitable for further analysis.

Stephan_Muhin_movie.sql contains SQL related cleaning data of the movie table and seperates atomic values for normalisation purposes.

Storm_01_normalize_movie.sql contains the junction tables to normalize columns with multiple valeus per movie.

Storm_02_box_office.sql contains SQL code to prepare and connect box_office information to the movie dataset. The datasets are linked through an URL reference

thomas_expert_review_complete.sql

Contains SQL used to prepare and structure the expert review data.

thomas_user_review_complete.sql

Similiar to expert:Contains SQL used to prepare and structure the user review data.
