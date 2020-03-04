#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ =  'Felipe Fronchetti'
__contact__ = 'fronchetti@usp.br'

import Crawler.crawler as GitCrawler
import Crawler.repository as GitRepository
from collections import OrderedDict
import multiprocessing
from datetime import datetime
from functools import partial
import json
import csv
import os

class Repository():
    def __init__(self, collector, folder):
        self.collector = collector
        self.folder = folder

        if not os.path.exists(self.folder):
            os.makedirs(self.folder)

    def get_about(self):
		'''
		Returns general information about the repository.
		Output: Dataset/{project-name}/about.json
		'''
		if not os.path.isfile(self.folder + '/about.json'):
			about = self.collector.get()

			with open(self.folder + '/about.json', 'w') as file:
				json.dump(about, file)

    def get_pull_requests(self):
		'''
		Returns all the pull requests created in the repository.
		Output: Dataset/{project-name}/pull_requests.json
		'''
		if not os.path.isfile(self.folder + '/pull_requests.json'):
			pull_requests = self.collector.pull_requests(state='all')
    
			with open(self.folder + '/pull_requests.json', 'w') as file:
				json.dump(pull_requests, file, indent = 4)

    def get_contributors(self):
		'''
		Returns all the contributors of the repository.
		Output: Dataset/{project-name}/contributors.json
		'''
		if not os.path.isfile(self.folder + '/contributors.json'):
			contributors = self.collector.contributors(anonymous='true')

			for contributor in contributors:
				if 'site_admin' in contributor.keys():
					# We defined the developers below as internals because we found qualitative evidences that they worked at GitHub
					if 'atom' in self.folder:
						if contributor['login'] == 'benogle' or contributor['login'] == 'thedaniel' or contributor['login'] == 'jlord':
							print contributor['login']
							contributor['site_admin'] = True
					if 'hubot' in self.folder:
						if contributor['login'] == 'bhuga' or contributor['login'] == 'aroben':
							contributor['site_admin'] = True
					if 'linguist' in self.folder:
						if contributor['login'] == 'arfon' or contributor['login'] == 'aroben' or contributor['login'] == 'tnm' or contributor['login'] == 'brandonblack' or contributor['login'] == 'rick':
							contributor['site_admin'] = True            
					if 'electron' in self.folder:
						if contributor['login'] == 'miniak' or contributor['login'] == 'codebytere':
							contributor['site_admin'] = True

			with open(self.folder + '/contributors.json', 'w') as file:
				json.dump(contributors, file, indent = 4)

    def summarize_merged_pull_requests(self):
		'''
		Summarize the necessary information about merged pull-requests in the repository.
		Output: Dataset/{project-name}/merged_pull_requests_summary.csv
		'''
		if os.path.isfile(self.folder + '/pull_requests.json') and not os.path.isfile(self.folder + '/merged_pull_requests_summary.csv'):
			with open(self.folder + '/pull_requests.json', 'r') as pull_requests:
				data = json.load(pull_requests)

				with open(self.folder + '/merged_pull_requests_summary.csv', 'a') as pull_requests_summary:
					fieldnames = ['pull_request', 'number_of_commits', 'number_of_comments','number_of_reviews','user_type',
					'user_login', 'merged_at', 'number_of_additions', 'number_of_deletions','number_of_files_changed','number_of_days', 'message']
					writer = csv.DictWriter(pull_requests_summary, fieldnames=fieldnames)
					writer.writeheader()

					for pull_request in data:
						if pull_request['merged_at'] != None:
							number_of_commits = self.collector.commits_in_pull_request(pull_request['number'])
							number_of_comments = self.collector.comments_in_pull_request(pull_request['number'])
							number_of_reviews = self.collector.reviews_in_pull_request(pull_request['number'])
							pull_request_data = self.collector.pull_request(pull_request['number'])

							number_of_files_changed = None
							number_of_additions = None
							number_of_deletions = None
							message = '#'

							if pull_request_data:
								if 'changed_files' in pull_request_data:
									number_of_files_changed = pull_request_data['changed_files']
								if 'additions' in pull_request_data:
									number_of_additions = pull_request_data['additions']
								if 'deletions' in pull_request_data:
									number_of_deletions = pull_request_data['deletions']
								if 'body' in pull_request_data:
									if pull_request_data['body'] != None:
										message = pull_request_data['body'].encode('utf-8')

							created_at = datetime.strptime(pull_request['created_at'], '%Y-%m-%dT%H:%M:%SZ')
							merged_at = datetime.strptime(pull_request['merged_at'], '%Y-%m-%dT%H:%M:%SZ')
							number_of_days = (merged_at - created_at).days

							if pull_request['user']['site_admin'] == True:
								writer.writerow({'pull_request': pull_request['number'], 'number_of_commits': len(number_of_commits), 'number_of_comments': len(number_of_comments), 'number_of_reviews': len(number_of_reviews), 'user_type': 'Internals', 'user_login': pull_request['user']['login'], 'merged_at':pull_request['merged_at'], 'number_of_additions': number_of_additions, 'number_of_deletions': number_of_deletions, 'number_of_files_changed': number_of_files_changed, 'number_of_days': number_of_days, 'message': message})
							else:
								writer.writerow({'pull_request': pull_request['number'], 'number_of_commits': len(number_of_commits), 'number_of_comments': len(number_of_comments), 'number_of_reviews': len(number_of_reviews), 'user_type': 'Externals', 'user_login': pull_request['user']['login'], 'merged_at':pull_request['merged_at'], 'number_of_additions': number_of_additions, 'number_of_deletions': number_of_deletions, 'number_of_files_changed': number_of_files_changed, 'number_of_days': number_of_days, 'message': message})

    def summarize_closed_pull_requests(self):
		'''
		Summarize the necessary information about closed pull-requests in the repository.
		Output: Dataset/{project-name}/closed_pull_requests_summary.csv
		'''
		if os.path.isfile(self.folder + '/pull_requests.json') and not os.path.isfile(self.folder + '/closed_pull_requests_summary.csv'):
			with open(self.folder + '/pull_requests.json', 'r') as pull_requests:
				data = json.load(pull_requests)

				with open(self.folder + '/closed_pull_requests_summary.csv', 'a') as pull_requests_summary:
					fieldnames = ['pull_request', 'number_of_commits', 'number_of_comments','number_of_reviews','user_type', 'user_login', 'closed_at', 
					'number_of_additions', 'number_of_deletions','number_of_files_changed','number_of_days', 'message']
					writer = csv.DictWriter(pull_requests_summary, fieldnames=fieldnames)
					writer.writeheader()

					for pull_request in data:
						if pull_request['state'] == 'closed' and pull_request['merged_at'] == None:
							number_of_commits = self.collector.commits_in_pull_request(pull_request['number'])
							number_of_comments = self.collector.comments_in_pull_request(pull_request['number'])
							number_of_reviews = self.collector.reviews_in_pull_request(pull_request['number'])
							pull_request_data = self.collector.pull_request(pull_request['number'])

							number_of_files_changed = None
							number_of_additions = None
							number_of_deletions = None
							message = '#'

							if pull_request_data:
								if 'changed_files' in pull_request_data:
									number_of_files_changed = pull_request_data['changed_files']
								if 'additions' in pull_request_data:
									number_of_additions = pull_request_data['additions']
								if 'deletions' in pull_request_data:
									number_of_deletions = pull_request_data['deletions']
								if 'body' in pull_request_data:
									if pull_request_data['body'] != None:
										message = pull_request_data['body'].encode('utf-8')

							created_at = datetime.strptime(pull_request['created_at'], '%Y-%m-%dT%H:%M:%SZ')
							closed_at = datetime.strptime(pull_request['created_at'], '%Y-%m-%dT%H:%M:%SZ')
							number_of_days = (closed_at - created_at).days

							if pull_request['user']['site_admin'] == True:
								writer.writerow({'pull_request': pull_request['number'], 'number_of_commits': len(number_of_commits), 'number_of_comments': len(number_of_comments), 'number_of_reviews': len(number_of_reviews), 'user_type': 'Internals', 'user_login': pull_request['user']['login'], 'closed_at': closed_at, 'number_of_additions': number_of_additions, 'number_of_deletions': number_of_deletions, 'number_of_files_changed': number_of_files_changed, 'number_of_days': number_of_days, 'message': message})
							else:
								writer.writerow({'pull_request': pull_request['number'], 'number_of_commits': len(number_of_commits), 'number_of_comments': len(number_of_comments), 'number_of_reviews': len(number_of_reviews), 'user_type': 'Externals', 'user_login': pull_request['user']['login'], 'closed_at': closed_at, 'number_of_additions': number_of_additions, 'number_of_deletions': number_of_deletions, 'number_of_files_changed': number_of_files_changed, 'number_of_days': number_of_days, 'message': message})

    def get_merged_pull_requests_reviews(self):
		'''
		Returns information about reviews made in merged pull-requests of the repository.
		Output: Dataset/{project-name}/merged_pull_requests_reviews.csv
		'''
		if os.path.isfile(self.folder + '/pull_requests.json') and not os.path.isfile(self.folder + '/merged_pull_requests_reviews.csv'):
			fieldnames = ['pull_request', 'creator', 'creator_type', 'reviewer', 'reviewer_type', 'is_equal']

			with open(self.folder + '/merged_pull_requests_reviews.csv', 'a') as file:
				writer = csv.DictWriter(file, fieldnames=fieldnames)
				writer.writeheader()

				with open(self.folder + '/pull_requests.json', 'r') as pull_requests:
					data = json.load(pull_requests)

					for pull_request in data:
						if pull_request['merged_at'] != None:
							review_page = self.collector.pull_request(pull_request['number'])

							# We defined the developers below as internals because we found qualitative evidences that they worked at GitHub
							creator = review_page['user']['login']

							if 'atom' in self.folder:
								if review_page['user']['login'] == 'benogle' or review_page['user']['login'] == 'thedaniel' or review_page['user']['login'] == 'jlord':
									review_page['user']['site_admin'] = True
							if 'hubot' in self.folder:
								if review_page['user']['login'] == 'bhuga' or review_page['user']['login'] == 'aroben':
									review_page['user']['site_admin'] = True
							if 'linguist' in self.folder:
								if review_page['user']['login'] == 'arfon' or review_page['user']['login'] == 'aroben' or review_page['user']['login'] == 'tnm' or review_page['user']['login'] == 'brandonblack' or review_page['user']['login'] == 'rick':
									review_page['user']['site_admin'] = True            
							if 'electron' in self.folder:
								if review_page['user']['login'] == 'miniak' or review_page['user']['login'] == 'codebytere':
									review_page['user']['site_admin'] = True

							if review_page['user']['site_admin'] == True:
								creator_type = 'Internals'
							else:
								creator_type = 'Externals'

							# We defined the developers below as internals because we found qualitative evidences that they worked at GitHub
							reviewer = review_page['merged_by']['login']

							if 'atom' in self.folder:
								if review_page['merged_by']['login'] == 'benogle' or review_page['merged_by']['login'] == 'thedaniel' or review_page['merged_by']['login'] == 'jlord':
									review_page['merged_by']['site_admin'] = True
							if 'hubot' in self.folder:
								if review_page['merged_by']['login'] == 'bhuga' or review_page['merged_by']['login'] == 'aroben':
									review_page['merged_by']['site_admin'] = True
							if 'linguist' in self.folder:
								if review_page['merged_by']['login'] == 'arfon' or review_page['merged_by']['login'] == 'aroben' or review_page['merged_by']['login'] == 'tnm' or review_page['merged_by']['login'] == 'brandonblack' or review_page['merged_by']['login'] == 'rick':
									review_page['merged_by']['site_admin'] = True            
							if 'electron' in self.folder:
								if review_page['merged_by']['login'] == 'miniak' or review_page['merged_by']['login'] == 'codebytere':
									review_page['merged_by']['site_admin'] = True    

							if review_page['merged_by']['site_admin'] == True:
								reviewer_type = 'Internals'
							else:
								reviewer_type = 'Externals'

							if creator == reviewer:
								is_equal = 'Yes'
							else:
								is_equal = 'No'

							writer.writerow({'pull_request': pull_request['number'], 'creator': creator, 'creator_type': creator_type, 'reviewer': reviewer, 'reviewer_type': reviewer_type, 'is_equal': is_equal})
	
    def get_casual_contributors(self):
		'''
		Returns information about the casual contributors of the repository.
		Output: Dataset/{project-name}/merged_pull_requests_reviews.csv
		'''
		if os.path.isfile(self.folder + '/pull_requests.json') and not os.path.isfile(self.folder + '/casual_contributors.csv'):
			internals = {}
			externals = {}

			with open(self.folder + '/pull_requests.json', 'r') as file:
				data = json.load(file)

				for pull_request in data:
					if pull_request['state'] == 'closed' and pull_request['merged_at'] != None:
						if pull_request['user']['site_admin'] == True:
							if pull_request['user']['login'] in internals:
								internals[pull_request['user']['login']] = internals[pull_request['user']['login']] + 1
							else:
								internals[pull_request['user']['login']] = 1 
						if pull_request['user']['site_admin'] == False:
							if pull_request['user']['login'] in externals:
								externals[pull_request['user']['login']] = externals[pull_request['user']['login']] + 1
							else:
								externals[pull_request['user']['login']] = 1

				with open(self.folder + '/casual_contributors.csv', 'w') as casual_contributors:
					fieldnames = ['username', 'url', 'user_type']
					writer = csv.DictWriter(casual_contributors, fieldnames=fieldnames)
					writer.writeheader()

					for external in externals:
						if externals[external] == 1:
							writer.writerow({'username': external, 'url': 'https://github.com/' + str(external), 'user_type': 'Externals'})

					for internal in internals:
						if internals[internal] == 1:
							writer.writerow({'username': internal, 'url': 'https://github.com/' + str(internal), 'user_type': 'Internals'})                

    def get_external_contributors(self):
		'''
		Returns information about the external contributors (volunteers) of the repository.
		Output: Dataset/{project-name}/merged_pull_requests_reviews.csv
		'''
		if os.path.isfile(self.folder + '/pull_requests.json') and not os.path.isfile(self.folder + '/external_contributors.csv'):
			externals = {}

			with open(self.folder + '/pull_requests.json', 'r') as file:
				data = json.load(file)

				for pull_request in data:
					if pull_request['state'] == 'closed' and pull_request['merged_at'] != None:
						if pull_request['user']['site_admin'] != True:

							if pull_request['user']['login'] in externals:
								externals[pull_request['user']['login']] = externals[pull_request['user']['login']] + 1
							else:
								externals[pull_request['user']['login']] = 1

				with open(self.folder + '/external_contributors.csv', 'w') as external_contributors:
					fieldnames = ['username', 'url', 'count']
					writer = csv.DictWriter(external_contributors, fieldnames=fieldnames)
					writer.writeheader()

					for external in sorted(externals, key=externals.get, reverse=True):
						writer.writerow({'username': external, 'url': 'https://github.com/' + str(external), 'count': externals[external]})

    def sort_pull_requests_by_month(self, pull_requests):
		'''
		Auxiliar method for get_pull_requests_per_month
		'''
		monthly_frequency = OrderedDict()
		for pull_request in pull_requests:
			month = datetime.strptime(pull_request['created_at'], '%Y-%m-%dT%H:%M:%SZ').date().replace(day=15)
			if month not in monthly_frequency:
				monthly_frequency[month] = 1
			else:
				monthly_frequency[month] = monthly_frequency[month] + 1
		return monthly_frequency

    def get_pull_requests_per_month(self):
		'''
		Returns information about the number of pull requests per month in the repository, divided by internals (employees) and externals (volunteers).
		Output: Dataset/{project-name}/pull_requests_per_month.csv
		'''
		if os.path.isfile(self.folder + '/pull_requests.json') and not os.path.isfile(self.folder + '/pull_requests_per_month.csv'):
			
			with open(self.folder + '/pull_requests.json', 'r') as file:
				data = json.load(file)

				employees_opened = []
				employees_closed = []
				employees_merged = []
				volunteers_opened = []
				volunteers_closed = []
				volunteers_merged = []

				for pull_request in data:
					# We defined the developers below as internals because we found qualitative evidences that they worked at GitHub
					if 'atom' in self.folder:
						if pull_request['user']['login'] == 'benogle' or pull_request['user']['login'] == 'thedaniel' or pull_request['user']['login'] == 'jlord':
							pull_request['user']['site_admin'] = True
					if 'hubot' in self.folder:
						if pull_request['user']['login'] == 'bhuga' or pull_request['user']['login'] == 'aroben':
							pull_request['user']['site_admin'] = True
					if 'linguist' in self.folder:
						if pull_request['user']['login'] == 'arfon' or pull_request['user']['login'] == 'aroben' or pull_request['user']['login'] == 'tnm' or pull_request['user']['login'] == 'brandonblack' or pull_request['user']['login'] == 'rick':
							pull_request['user']['site_admin'] = True            
					if 'electron' in self.folder:
						if pull_request['user']['login'] == 'miniak' or pull_request['user']['login'] == 'codebytere':
							pull_request['user']['site_admin'] = True            

					if pull_request['state'] == 'open':
						if pull_request['user']['site_admin'] == True:
							employees_opened.append(pull_request)
						else:
							volunteers_opened.append(pull_request)
					if pull_request['state'] == 'closed':
						if pull_request['merged_at'] == None:
							if pull_request['user']['site_admin'] == True:
								employees_closed.append(pull_request)
							else:
								volunteers_closed.append(pull_request)
						else:
							if pull_request['user']['site_admin'] == True:
								employees_merged.append(pull_request)
							else:
								volunteers_merged.append(pull_request)

				employees_opened = self.sort_pull_requests_by_month(employees_opened)
				employees_closed = self.sort_pull_requests_by_month(employees_closed)
				employees_merged = self.sort_pull_requests_by_month(employees_merged)
				volunteers_opened = self.sort_pull_requests_by_month(volunteers_opened)
				volunteers_closed = self.sort_pull_requests_by_month(volunteers_closed)
				volunteers_merged = self.sort_pull_requests_by_month(volunteers_merged)

				with open(self.folder + '/pull_requests_per_month.csv', 'w') as pull_requests_per_month:
					fieldnames = ['month', 'pull_type', 'pull_amount', 'user_type']
					writer = csv.DictWriter(pull_requests_per_month, fieldnames=fieldnames)
					writer.writeheader()
					for date in employees_opened:
						writer.writerow({'month': date, 'pull_type': 'opened', 'pull_amount': employees_opened[date], 'user_type':'Internals'})
					for date in employees_closed:
						writer.writerow({'month': date, 'pull_type': 'closed', 'pull_amount': employees_closed[date], 'user_type':'Internals'})
					for date in employees_merged:
						writer.writerow({'month': date, 'pull_type': 'merged', 'pull_amount': employees_merged[date], 'user_type':'Internals'})
					for date in volunteers_opened:
						writer.writerow({'month': date, 'pull_type': 'opened', 'pull_amount': volunteers_opened[date], 'user_type':'Externals'})
					for date in volunteers_closed:  
						writer.writerow({'month': date, 'pull_type': 'closed', 'pull_amount': volunteers_closed[date], 'user_type':'Externals'})
					for date in volunteers_merged:
						writer.writerow({'month': date, 'pull_type': 'merged', 'pull_amount': volunteers_merged[date], 'user_type':'Externals'})

def repositories_in_parallel(project):
	collector = GitRepository.Repository(project['organization'], project['name'], crawler)
	folder = dataset_folder + '/' + project['name']

	project = Repository(collector, folder)
	project.get_about()
	project.get_pull_requests()
	project.get_merged_pull_requests_reviews()
	project.get_contributors()
	project.summarize_merged_pull_requests()
	project.summarize_closed_pull_requests()
	project.get_casual_contributors()
	project.get_external_contributors()
	project.get_pull_requests_per_month()

if __name__ == '__main__':
	dataset_folder = 'Dataset'
	
	if not os.path.exists(dataset_folder):
		os.makedirs(dataset_folder)

	projects = [{'organization':'electron','name':'electron'},
                {'organization':'github','name':'linguist'},
                {'organization':'git-lfs','name':'git-lfs'},
                {'organization':'hubotio','name':'hubot'},
                {'organization':'atom','name':'atom'}]

	api_client_id = '$' # Please, specify your own client id
	api_client_secret = '$' # Please, specify your own client secret
	crawler = GitCrawler.Crawler(api_client_id, api_client_secret)

	parallel = multiprocessing.Pool(processes=4)
	parallel.map(partial(repositories_in_parallel), projects)

