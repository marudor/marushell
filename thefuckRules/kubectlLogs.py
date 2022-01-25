import re

def match(command):
    return ('error: a container name must be specified for pod' in command.output.lower())

def get_new_command(command):
    search = re.search('of: \[(.+) .*\]', command.output)
    if (search):
        return '{} {}'.format(command.script, search.group(1))
