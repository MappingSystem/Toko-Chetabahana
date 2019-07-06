from gittle import Gittle

# Clone a repository
repo_path = '/tmp/gittle_bare'
repo_url = 'git://github.com/FriendCode/gittle.git'
repo = Gittle.clone(repo_url, repo_path)

# Stage multiple files
repo.stage(['other1.txt', 'other2.txt'])

# Do the commit
repo.commit(name="Samy Pesse", email="samy@friendco.de", message="This is a commit")

# Authentication with RSA private key
key_file = open('/Users/Me/keys/rsa/private_rsa')
repo.auth(pkey=key_file)

# Do push
repo.push()
