from elasticsearch import Elasticsearch 
import sys

es= Elasticsearch()
q = sys.argv[1]
search_results = es.search(index = 'elasticsearch_demo',  
                           body = {"_source":"name",
                                 'query':{
                                     'match_phrase':{"content": q},
                                      } 
                            })

