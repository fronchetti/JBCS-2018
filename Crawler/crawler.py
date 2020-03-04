#!/usr/bin/env python
# -*- coding: utf-8 -*- 

__author__ =  'Felipe Fronchetti'
__contact__ = 'fronchetti@usp.br'

import urllib2
import time
import datetime
import json

class Crawler:
    '''
    Class responsible for performing each request in the GitHub API (V3).
    Documentation: https://developer.github.com/v3/#schema
    '''
    def __init__(self, client_id, client_secret):
        self.id = client_id
        self.secret = client_secret
        self.rate_limit_remaining = None
        self.rate_limit_reset = None

    def request(self, request, parameters=None):
        '''
        Makes the request using oauth client id and secret
        Output: json object with the requested data
        '''
        try:
            if parameters is None:
                print('Processing request: ' + request)
                url = 'https://api.github.com/' + request + '?client_id=' + self.id + '&client_secret=' + self.secret
            else:
                print('Processing request: ' + request + ' ' + str(parameters))
                url = 'https://api.github.com/' + request + '?client_id=' + self.id + '&client_secret=' + self.secret + '&' + '&'.join(parameters)

            response = urllib2.urlopen(url)
            header = response.info()
            body = json.load(response)
            self.verify_rate_limit(header)

            return body

        except (urllib2.URLError, urllib2.HTTPError) as error:
            self.wait_internet_connection(request, parameters)

            with open('error.log', 'a') as error_file:
                error_file.write('Found a error in request: \n')
                if parameters is None:
                    error_file.write('https://api.github.com/' + request + 'client_id=' + self.id + '&client_secret=' + self.secret + '\n')
                else:
                    error_file.write('https://api.github.com/' + request + '?client_id=' + self.id + '&client_secret=' + self.secret + '&' + '&'.join(parameters) + '\n')
                error_file.write('Error type: ' + str(error) + '\n\n')
            pass
        except: 
            pass

    def verify_rate_limit(self, header):
        '''
        Verifies if API requests limit is over. If it is, the process goes sleep.
        Documentation: https://developer.github.com/v3/#rate-limiting
        '''
        for item in header.items():
            if 'x-ratelimit-remaining' in item:
                self.rate_limit_remaining = int(item[1])
            if 'x-ratelimit-reset' in item:
                self.rate_limit_reset = int(item[1])

        datetime_format = '%Y-%m-%d %H:%M:%S'
        datetime_reset = datetime.datetime.fromtimestamp(
            self.rate_limit_reset).strftime(datetime_format)
        datetime_now = datetime.datetime.now().strftime(datetime_format)

        print('[API] Requests Remaining:' + str(self.rate_limit_remaining))

        if self.rate_limit_remaining < 10:
            while(datetime_reset > datetime_now):
                print 'The request limit is over. The process is sleeping until it can be resumed.'
                print 'The limit will reset on: ' + datetime_reset
                datetime_now = datetime.datetime.now().strftime(datetime_format)
                time.sleep(120)

    def get_rate_limit_remaining(self):
        return self.rate_limit_remaining

    def get_rate_limit_reset(self):
        return self.rate_limit_reset

    def wait_internet_connection(self, request, parameters):
        '''
        Verifies if internet is working properly. If it is, the process keeps running.
        Documentation: https://developer.github.com/v3/#rate-limiting
        '''
        while True:
            try:
                response = urllib2.urlopen('https://github.com', timeout=1)
                if response:
                    print('Internet is working! Returning with the crawling.')
                return
            except urllib2.URLError:
                print('The connection does not seem to be working. Trying again.')
                time.sleep(30)
                pass
