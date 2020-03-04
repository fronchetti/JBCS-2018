#!/usr/bin/env python
# -*- coding: utf-8 -*- 

__author__ =  'Felipe Fronchetti'
__contact__ = 'fronchetti@usp.br'

class Repository:
    '''
    Class allows the developer to retrieve information about a particular repository on GitHub
    '''
    
    def __init__(self, owner, name, crawler):
        self.name = name
        self.owner = owner
        self.github = crawler

    def get(self):
        '''
        Returns general information about the repository
        Output: JSON
        Documentation: https://developer.github.com/v3/repos/#get
        '''
        print('[Repository] Returning general information')
        return self.github.request('repos/' + self.owner + '/' + self.name)

    def languages(self):
        '''
        Returns the programming languages used in the repository
        Output: JSON
        Documentation: https://developer.github.com/v3/repos/#list-languages
        '''
        print('[Repository] Returning languages used in the project')
        return self.github.request('repos/' + self.owner + '/' + self.name + '/languages')

    def commits(self, sha=None, path=None, author=None,
                since=None, until=None, page_range=None):
        '''
        Returns commits created in the repository (All method parameters are optional)
        Output: JSON
        Documentation: https://developer.github.com/v3/repos/commits/#list-commits-on-a-repository
        '''
        commits = []
        parameters = []

        if sha is not None:
            parameters.append('sha=' + sha)

        if path is not None:
            parameters.append('path=' + path)

        if author is not None:
            parameters.append('author=' + author)

        if since is not None:
            parameters.append('since=' + since)

        if until is not None:
            parameters.append('until=' + until)

        if page_range is not None:
            print('[Repository] Returning commits in a range')

            first_page = page_range[0]
            last_page = page_range[1]

            for page_number in range(first_page, last_page):
                request = self.github.request('repos/' + self.owner + '/' + self.name + '/commits', parameters + ['page=' + str(page_number)])
                for commit in request:
                    commits.append(commit)

        else:
            print('[Repository] Returning all commits created in the project')
            request = ['Waiting for requisition...']
            page_number = 1

            while(request):
                request = self.github.request('repos/' + self.owner + '/' + self.name + '/commits', parameters + ['page=' + str(page_number)])
                if request:
                    for commit in request:
                        commits.append(commit)
                page_number = page_number + 1

        return commits

    def pull_request(self, number):
        '''
        Returns a specific pull request based on number
        Output: JSON
        Documentation: https://developer.github.com/v3/pulls/#get-a-single-pull-request
        '''
        print('[Repository] Returning pull-request #' + str(number) + ' from project')
        return self.github.request('repos/' + self.owner + '/' + self.name + '/pulls/' + str(number))

    def pull_requests(self, state=None, direction=None, sort=None,
                      base=None, head=None, page_range=None):
        '''
        Returns pull requests created in the project (All method parameters are optional)
        Output: JSON
        Documentation: https://developer.github.com/v3/pulls/#list-pull-requests
        '''
        pull_requests = []
        parameters = []

        if state is not None:
            parameters.append('state=' + state)
        if direction is not None:
            parameters.append('direction=' + direction)
        if sort is not None:
            parameters.append('sort=' + sort)
        if base is not None:
            parameters.append('base=' + base)
        if head is not None:
            parameters.append('head=' + head)

        if page_range is not None:
            print('[Repository] Returning pull requests in a range')
            first_page = page_range[0]
            last_page = page_range[1]

            for page_number in range(first_page, last_page):
                request = self.github.request('repos/' + self.owner + '/' + self.name + '/pulls', parameters + ['page=' + str(page_number)])
                for pull in request:
                    pull_requests.append(pull)
        else:
            print('[Repository] Returning all pull requests created in the project')
            request = ['Waiting for requisition...']
            page_number = 1

            while(request):
                request = self.github.request('repos/' + self.owner + '/' + self.name + '/pulls', parameters + ['page=' + str(page_number)])
                if request:
                    for pull in request:
                        pull_requests.append(pull)
                page_number = page_number + 1
        return pull_requests

    def issue(self, number):
        '''
        Returns a specific issue based on number
        Output: JSON
        Documentation: https://developer.github.com/v3/issues/#get-a-single-issue
        '''
        print('[Repository] Returning issue #' + str(number) + ' from project')
        return self.github.request('repos/' + self.owner + '/' + self.name + '/issues/' + str(number))

    def issues(self, state=None, direction=None, milestone=None, labels=None,
               creator=None, since=None, assignee=None, mentioned=None, page_range=None):
        '''
        Returns issues created in the project (All method parameters are optional)
        Output: JSON
        Documentation: https://developer.github.com/v3/issues/#list-issues-for-a-repository
        '''
        issues = []
        parameters = []

        if state is not None:
            parameters.append('state=' + state)
        if direction is not None:
            parameters.append('direction=' + direction)
        if labels is not None:
            parameters.append('labels=' + labels)
        if creator is not None:
            parameters.append('creator=' + creator)
        if since is not None:
            parameters.append('since=' + since)
        if milestone is not None:
            parameters.append('milestone=' + milestone)
        if mentioned is not None:
            parameters.append('mentioned=' + mentioned)
        if assignee is not None:
            parameters.append('assignee=' + assignee)

        if page_range is not None:
            print('[Repository] Returning issues in a page range')
            first_page = page_range[0]
            last_page = page_range[1]

            for page_number in range(first_page, last_page):
                request = self.github.request('repos/' + self.owner + '/' + self.name + '/issues', parameters + ['page=' + str(page_number)])
                for issue in request:
                    issues.append(issue)
        else:
            print('[Repository] Returning all issues in the project')
            request = ['Waiting for requisition...']
            page_number = 1

            while(request):
                request = self.github.request('repos/' + self.owner + '/' + self.name + '/issues', parameters + ['page=' + str(page_number)])
                if request:
                    for issue in request:
                        issues.append(issue)
                page_number = page_number + 1
        return issues

    def contributors(self, anonymous='false', page_range=None):
        '''
        Returns contributors in the project (All parameters are optional)
        Output: JSON
        Documentation: https://developer.github.com/v3/repos/#list-contributors
        '''
        contributors = []

        if page_range is not None:
            print('[Repository] Returning contributors in a page range')
            first_page = page_range[0]
            last_page = page_range[1]

            for page_number in range(first_page, last_page):
                request = self.github.request('repos/' + self.owner + '/' + self.name + '/contributors', ['page=' + str(page_number), 'anon=' + str(anonymous)])

                for contributor in request:
                    contributors.append(contributor)
        else:
            print('[Repository] Returning all contributors in the project')
            request = ['Waiting for requisition']
            page_number = 1

            while(request):
                request = self.github.request('repos/' + self.owner + '/' + self.name + '/contributors', ['page=' + str(page_number), 'anon=' + str(anonymous)])

                if request:
                    for contributor in request:
                        contributors.append(contributor)
                page_number = page_number + 1
        return contributors

    def commits_in_pull_request(self, number):
        '''
        Returns commits created in a pull request of the project
        Output: JSON
        '''
        commits = []
        request = ['Waiting for requisition']
        page_number = 1

        print('[Repository] Returning all commits in pull request #' + str(number))

        while(request):
            request = self.github.request('repos/' + self.owner + '/' + self.name + '/pulls/' + str(number) + '/commits', ['page=' + str(page_number)])
            if request:
                for commit in request:
                    commits.append(commit)            
            page_number = page_number + 1

        return commits

    def comments_in_pull_request(self, number):
        '''
        Returns comments created in a pull request of the project
        Output: JSON
        '''
        comments = []
        request = ['Waiting for requisition']
        page_number = 1

        print('[Repository] Returning all comments in pull request #' + str(number))

        while(request):
            request = self.github.request('repos/' + self.owner + '/' + self.name + '/issues/' + str(number) + '/comments', ['page=' + str(page_number)])
            if request:
                for comment in request:
                    comments.append(comment)            
            page_number = page_number + 1
        return comments

    def reviews_in_pull_request(self, number):
        '''
        Returns reviews created in a pull request of the project
        Output: JSON
        '''
        reviews = []
        request = ['Waiting for requisition']
        page_number = 1

        print('[Repository] Returning all reviews in pull request #' + str(number))

        while(request):
            request = self.github.request('repos/' + self.owner + '/' + self.name + '/pulls/' + str(number) + '/comments', ['page=' + str(page_number)])
            if request:
                for review in request:
                    reviews.append(review)
            page_number = page_number + 1
        return reviews

    def files_in_pull_request(self, number):
        '''
        Returns files created/modified in a pull request of the project
        Output: JSON
        '''
        files = []
        request = ['Waiting for requisition']
        page_number = 1

        print('[Repository] Returning all files in pull request #' + str(number))

        while(request):
            request = self.github.request('repos/' + self.owner + '/' + self.name + '/pulls/' + str(number) + '/files', ['page=' + str(page_number)])
            if request:
                for file in request:
                    files.append(file)            
            page_number = page_number + 1
        return files
