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

    def about(self):
        about_file = self.folder + '/about.json'

        if not os.path.isfile(about_file):
            about = self.collector.get()

            with open(about_file, 'w') as file:
                json.dump(about, file, indent = 4)

    def pull_requests(self):
        pulls_file = self.folder + '/pulls.json'

        if not os.path.isfile(pulls_file):
            pull_requests = self.collector.pull_requests(state='all')
    
            with open(pulls_file, 'w') as file:
                json.dump(pull_requests, file, indent = 4)

    def commits(self):
        commits_file = self.folder + '/commits.json'

        if not os.path.isfile(commits_file):
            commits = self.collector.commits()
    
            with open(commits_file, 'w') as file:
                json.dump(commits, file, indent = 4)

    def forks(self):
        forks_file = self.folder + '/forks.json'

        if not os.path.isfile(forks_file):
            forks = self.collector.forks()
    
            with open(forks_file, 'w') as file:
                json.dump(forks, file, indent = 4)

def repositories_in_parallel(project):
    collector = GitRepository.Repository(project['organization'], project['name'], crawler)
    folder = dataset_folder + project['name']

    R = Repository(collector, folder)
    R.about()
    R.pull_requests()
    R.commits()
    R.forks()

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
    parallel = multiprocessing.Pool(processes=5) # Define number of processes
    parallel.map(partial(repositories_in_parallel), projects)