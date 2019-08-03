from gittle import Gittle

# Constants
repo_path = '/Users/aaron/git/gittle'
repo_url = 'git@friendco.de:friendcode/gittle.git'
key_file = open('/root/.ssh/id_rsa')

# Gittle repo
git = Gittle(repo_path, origin_uri=repo_url)

# Authentication
git.status()
git.auth(pkey=key_file)
git.stage(git.modified_files)
git.commit(name="Me",email="myvalid@email.com",message="test?")

# Do push
git.push(remote, branch)
