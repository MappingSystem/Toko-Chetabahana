# Set Deploy Automation
See [Setel Otomatisasi Deploy](https://github.com/MarketLeader/Tutorial-Buka-Toko/wiki/Setel-Otomatisasi-Deploy) or [Translation](https://translate.google.com/translate?hl=en&sl=id&tl=en&u=https%3A%2F%2Fgithub.com%2FMarketLeader%2FTutorial-Buka-Toko%2Fwiki%2FSetel-Otomatisasi-Deploy)


## cloudbuild.yaml
```
steps:
- name: "gcr.io/cloud-builders/gcloud" #ref: https://cloud.google.com/cloud-build/docs/build-config
  args: ["compute", "ssh", "${_USER_NAME}@${_INSTANCE_NAME}", "--zone", "${_ZONE}", "--command", "cd ${_DOCKER_DIRECTORY} && echo '
#!/bin/sh\n
...\n
shell code\n
...\n
#EOF\n
' > git.txt && rm -rf git.sh && mv git.txt git.sh && chmod +x git.sh && ./git.sh"]
```
