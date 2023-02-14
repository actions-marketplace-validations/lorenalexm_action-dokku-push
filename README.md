# action-dokku-deploy
Easily deploy an app to your Dokku Instance from GitHub

This fork simply takes the work done by [`obrassard/action-dokku-push`](https://github.com/obrassard/action-dokku-push) and forces use of the `main` GitHub branch.

### Requirements

Please note that this action is compatible with `dokku >= 0.11.6`.

## Inputs

#### `dokku_repo`

**Required**. The dokku app's git repository url **(in SSH format)**. 

Example : `ssh://dokku@dokku.me:22/appname`

***

#### `ssh_key`

**Required**. An private ssh key that has push acces to your Dokku instance. 

Example :

```
-----BEGIN OPENSSH PRIVATE KEY-----
MIIEogIBAAKCAQEAjLdCs9kQkimyfOSa8IfXf4gmexWWv6o/IcjmfC6YD9LEC4He
qPPZtAKoonmd86k8jbrSbNZ/4OBelbYO0pmED90xyFRLlzLr/99ZcBtilQ33MNAh
...
SvhOFcCPizxFeuuJGYQhNlxVBWPj1Jl6ni6rBoHmbBhZCPCnhmenlBPVJcnUczyy
zrrvVLniH+UTjreQkhbFVqLPnL44+LIo30/oQJPISLxMYmZnuwudPN6O6ubyb8MK
-----END OPENSSH PRIVATE KEY-----

```

> :bulb: Tip : It is recommanded to use **GitHub Actions Secrets** to store sensible informations like SSH Keys

***

## Example usage 

This action is particularly useful when triggered by new pushes :

```yml
name: 'Deploy to my Dokku instance'

on:
  push:
    branches:
    - master

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
  
    - name: Cancel Previous Runs # Optional step 
      uses: styfle/cancel-workflow-action@0.4.0
      with:
        access_token: ${{ github.token }}
    
    - name: Cloning repo # This step is required
      uses: actions/checkout@v2
      with:
        fetch-depth: 0 # This is required or you might get an error from Dokku

    - name: Push to dokku
      uses: obrassard/action-dokku-deploy@v1.0.2
      with:
        dokku_repo: 'ssh://dokku@dokku.me:22/appname'
        ssh_key: ${{ secrets.SSH_KEY }}
```

