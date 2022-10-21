# Chuck's homefiles
On each of my machines I setup I import this repo and use it as a storage location for my playbooks, documentation, and scripts. It serves as version control and a backup in the event my laptop explodes.

## bin/*
Little scripts I make for whatever reason. Purpose for each script is commented inside

## notes/*
Technical documentation I just toss into here for future reference

## playbooks/*
My Ansible playbooks to configure all my various servers. I start with base-config.yaml then go from there.

I use the latest version of Debian for each one in general, and usually provision a server on Google Cloud Services.

I've generally begun retiring these and switching to micro-services type of approach with my servers - makes it easier to manage and allows for an automatic CI/CD style pipeline

## powershell/*
Powershell scripts I use from time to time

## systemd/*
Systemd scripts that aren't hooked up into an Ansible playbook