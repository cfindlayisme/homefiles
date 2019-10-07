# Deploys to gcs functions to control minecraft server
# 
# Currently just controls one, but in the future will adjust
# Also need to work on client interface
#
# Author: Chuck Findlay <chuck@findlayis.me>
# License: LGPL v3.0
from googleapiclient import discovery
from oauth2client.client import GoogleCredentials
import os

def minecraft(request):
    action = request.json.get('action')

    if action == 'start':
        return start()
    elif action == 'stop':
        return stop()

    return "No command provided"

def start():
    credentials = GoogleCredentials.get_application_default()

    service = discovery.build('compute', 'v1', credentials=credentials)

    project = os.environ.get('project')
    zone = os.environ.get('zone')
    instance = os.environ.get('instance')

    request = service.instances().start(project=project, zone=zone, instance=instance)
    response = request.execute()

    if (response != None):
        return "Started"
    return "Error"

def stop():
    credentials = GoogleCredentials.get_application_default()

    service = discovery.build('compute', 'v1', credentials=credentials)

    project = os.environ.get('project')
    zone = os.environ.get('zone')
    instance = os.environ.get('instance')

    request = service.instances().stop(project=project, zone=zone, instance=instance)
    response = request.execute()

    if (response != None):
        return "Stopped"
    return "Error"

if __name__ == '__main__':
    from flask import Flask, request
    app = Flask(__name__)

    @app.route('/', methods=['POST', 'GET'])
    def test():
        return minecraft(request)

    app.run('127.0.0.1', 8000, debug=True)