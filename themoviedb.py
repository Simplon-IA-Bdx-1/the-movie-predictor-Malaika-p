import datetime
import requests
# from datetime import datetime
from movie import Movie
import os
from dotenv import load_dotenv
load_dotenv()

class TheMovieDB:

    ENDPOINT = "api.themoviedb.org/3"
    DEFAULT_QUERY_PARAMS = {
        "language": "fr-FR"
    }

    def __init__(self):
        api_key = os.getenv("TMDB_API_KEY")
        self.query_params = {
            "api_key": api_key
        }
        self.query_params.update(TheMovieDB.DEFAULT_QUERY_PARAMS)

    def get_movie(self, imdb_id):
        response = requests.get(f"https://{TheMovieDB.ENDPOINT}/movie/{imdb_id}", params=self.query_params)
        if (response.status_code != 200):
            print("Error in request")
            return None
        dict_response = response.json()
        return self.movie_from_json(dict_response)

    def movie_from_json(self, dict_movie):
        
        title = dict_movie['title']
        
        
        original_title = dict_movie['original_title']
        duration = dict_movie['runtime']
        release_date = datetime.datetime.strptime(dict_movie['release_date'], '%Y-%m-%d')
        rating = None
        synopsis = dict_movie['overview']
        production_budget = dict_movie['budget']

        movie = Movie(title, original_title, duration, release_date, rating)
        movie.synopsis = synopsis
        movie.production_budget = production_budget

        return movie


    def get_list_movies(self):
        print('hello1')
        date = datetime.datetime.today()

        date_end_ok = datetime.datetime.today().strftime('%Y-%m-%d')
        delais = datetime.timedelta(days=7)

        date_end = datetime.datetime.today() - delais
        date_start = datetime.datetime.strftime(date_end, '%Y-%m-%d')
                        
        page = 1
        response = requests.get(f"https://{TheMovieDB.ENDPOINT}/discover/movie?language=en-US&include_adult=false&include_video=false&page={page}&primary_release_date.gte={date_start}&primary_release_date.lte={date_end_ok}", params=self.query_params)
        dict_response = response.json()
        page_total = 1 + int(dict_response['total_pages'])

        movies_list = []
        for page in range(1,page_total):
            response = requests.get(f"https://{TheMovieDB.ENDPOINT}/discover/movie?language=en-US&include_adult=false&include_video=false&page={page}&primary_release_date.gte={date_start}&primary_release_date.lte={date_end_ok}", params=self.query_params)
            dict_response = response.json()
            page += 1
            
            for dict_movie in dict_response['results']:
                
                title = dict_movie['title']
                original_title = dict_movie['original_title']
                duration = None
                release_date = datetime.datetime.strptime(dict_movie['release_date'], '%Y-%m-%d')
                rating = None
                synopsis = dict_movie['overview']
                production_budget = None

                movie = Movie(title, original_title, duration, release_date, rating)
                movies_list.append(movie)
        return movies_list

        

            