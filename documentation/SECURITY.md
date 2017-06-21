# CoreOs Clair
The Clair project is an open source engine that powers Quay Security Scanner to detect vulnerabilities in all images within Quay Enterprise, and notify developers as those issues are discovered.

# What is CoreOs Clair
Clair is an open source project for the static analysis of vulnerabilities in application containers (currently including appc and docker).
1. In regular intervals, Clair ingests vulnerability metadata from a configured set of sources and stores it in the database.
2. Clients use the Clair API to index their container images; this parses a list of installed source packages and stores them in the database.
3. Clients use the Clair API to query the database; correlating data is done in real time, rather than a cached result that needs re-scanning.
4. When updates to vulnerability metadata occur, a webhook containg the affected images can be configured to page or block deployments.
Our goal is to enable a more transparent view of the security of container-based infrastructure. Thus, the project was named Clair after the French term which translates to clear, bright, transparent.

![Clair](https://cloud.githubusercontent.com/assets/343539/21630809/c1adfbd2-d202-11e6-9dfe-9024139d0a28.png)

# Installing & Start Clair
CoreOS Clair required:
- Docker
- Docker-compose

You need to download docker compose file and Clair configuration

```
curl -L https://raw.githubusercontent.com/coreos/clair/master/docker-compose.yml -o docker-compose.yml
mkdir clair_config
curl -L https://raw.githubusercontent.com/coreos/clair/master/config.example.yaml -o clair_config/config.yaml
$EDITOR clair_config/config.yaml
docker-compose -f docker-compose.yml up -d
```

## About the configuration file
Clair's configuration must be set by the user. You have to set the postgresql POSTGRES_CONNECTION_STRING and else. 
Look at this document for more informations https://coreos.com/quay-enterprise/docs/latest/clair.html#clair-configuration-high-availability.

# Installing Clairctl
Clairctl is a additional cli to use clair, it's useful for developpers.
```
sudo curl -L https://raw.githubusercontent.com/jgsqware/clairctl/master/install.sh | sh
```

# Local environement (Dev)
After build, pull, commit an image, you can analyse it and report with clairstl. In local environement the analyze is not automatic that's why clairctl is required.
```
clairctl push -l myImageName
clairctl analyze -l myImageName
```

# Analyze report (HTML or JSON)
To report analysis, you should launch this command. You have two formats of reporting, JSON or Html file. 
Reports containers contains a list of sercurity failure (name, type, description link) for each image layers.
```
clairctl report -l myImageName
```
