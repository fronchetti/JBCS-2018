try:
    import Crawler.crawler as GitCrawler
    import Crawler.repository as GitRepository
    import multiprocessing
    from functools import partial
    import json
    import csv
    import os
except ImportError as error:
    raise ImportError(error)

class Repository():
    def __init__(self, collector, folder):
        self.collector = collector
        self.folder = folder

        if not os.path.exists(self.folder):
            os.makedirs(self.folder)

    # Collects general information about a project (Source: GitHub API)
    def about(self):
        about_file = self.folder + '/about.json'

        if not os.path.isfile(about_file):
            about = self.collector.get()

            with open(about_file, 'w') as file:
                json.dump(about, file, indent = 4)

    # Collects all the project's pull requests. (Source: GitHub API)
    def pull_requests(self):
        pulls_file = self.folder + '/pull_requests.json'

        if not os.path.isfile(pulls_file):
            pull_requests = self.collector.pull_requests(state='all')
    
            with open(pulls_file, 'w') as file:
                json.dump(pull_requests, file, indent = 4)

    # Creates a summary of pull request's information. (Source: pull_requests.json)
    # Contains: user position (volunteer/employee), user login, pull request merged date, num. of commits, comments and reviews.
    def merged_pull_requests_summary(self):
        pulls_file = self.folder + '/pull_requests.json'
        pulls_summary_file = self.folder + '/merged_pull_requests_summary.csv'

        if os.path.isfile(pulls_file) and not os.path.isfile(pulls_summary_file):
            with open(pulls_file, 'r') as pulls:
                data = json.load(pulls)

                with open(pulls_summary_file, 'a') as output:
                    fieldnames = ['pull_request', 'number_of_commits', 'number_of_comments','number_of_reviews','user_type', 'user_login', 'merged_at', 'number_of_additions', 'number_of_deletions','number_of_files_changed']
                    writer = csv.DictWriter(output, fieldnames=fieldnames)
                    writer.writeheader()

                    for pull_request in data:
                        if pull_request['merged_at'] != None:
                            number_of_commits = self.collector.commits_in_pull_request(pull_request['number'])
                            number_of_comments = self.collector.comments_in_pull_request(pull_request['number'])
                            number_of_reviews = self.collector.reviews_in_pull_request(pull_request['number'])

                            number_of_additions = 0
                            number_of_deletions = 0
                            number_of_files_changed = 0

                            for commit in number_of_commits:
                                url = commit['url']
                                commit_information = self.collector.commit_information(url)

                                if 'stats' in commit_information:
                                    number_of_additions = number_of_additions + int(commit_information['stats']['additions'])
                                    number_of_deletions = number_of_deletions + int(commit_information['stats']['deletions'])
                                if 'files' in commit_information:
                                    number_of_files_changed = number_of_files_changed + len(commit_information['files'])


                            if pull_request['user']['site_admin'] == True:
                                writer.writerow({'pull_request': pull_request['number'], 'number_of_commits': len(number_of_commits), 'number_of_comments': len(number_of_comments), 'number_of_reviews': len(number_of_reviews), 'user_type': 'Employees', 'user_login': pull_request['user']['login'], 'merged_at':pull_request['merged_at'], 'number_of_additions': number_of_additions, 'number_of_deletions': number_of_deletions, 'number_of_files_changed': number_of_files_changed})
                            else:
                                writer.writerow({'pull_request': pull_request['number'], 'number_of_commits': len(number_of_commits), 'number_of_comments': len(number_of_comments), 'number_of_reviews': len(number_of_reviews), 'user_type': 'Volunteers', 'user_login': pull_request['user']['login'], 'merged_at':pull_request['merged_at'], 'number_of_additions': number_of_additions, 'number_of_deletions': number_of_deletions, 'number_of_files_changed': number_of_files_changed})

def repositories_in_parallel(project):
    collector = GitRepository.Repository(project['organization'], project['name'], crawler)
    folder = dataset_folder + project['name']

    R = Repository(collector, folder)
    R.about()
    R.pull_requests()
    R.merged_pull_requests_summary()

if __name__ == '__main__':
    dataset_folder = 'Dataset/'
    projects = [{'organization':'electron','name':'electron'},
    {'organization':'github','name':'linguist'},
    {'organization':'git-lfs','name':'git-lfs'},
    {'organization':'hubotio','name':'hubot'},
    {'organization':'atom','name':'atom'}]

    if not os.path.exists(dataset_folder):
        os.makedirs(dataset_folder)

    api_client_id = '4161a8257efaea420c94' # Please, specify your own client id
    api_client_secret = 'd814ec48927a6bd62c55c058cd028a949e5362d4' # Please, specify your own client secret
    crawler = GitCrawler.Crawler(api_client_id, api_client_secret)

    # Multiprocessing technique
    parallel = multiprocessing.Pool(processes=4) # Define number of processes
    parallel.map(partial(repositories_in_parallel), projects)

