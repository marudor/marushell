#!/usr/bin/env sh
git clone https://github.com/jasongin/nvs "$HOME/.nvs"

brew install kubectl
brew cask install google-cloud-sdk

gcloud config configurations create production
gcloud config configurations activate production
gcloud config set project production-1077
gcloud config set compute/region europe-west1
gcloud config set compute/zone europe-west1-d
 
gcloud config configurations create staging
gcloud config configurations activate staging
gcloud config set project everyjob-1020
gcloud config set compute/region europe-west1
gcloud config set compute/zone europe-west1-d
 
gcloud config configurations create development
gcloud config configurations activate development
gcloud config set project development-666
gcloud config set compute/region europe-west1
gcloud config set compute/zone europe-west1-d
 
gcloud config configurations create integration
gcloud config configurations activate integration
gcloud config set project integration-007
gcloud config set compute/region europe-west1
gcloud config set compute/zone europe-west1-d

gconf s
gcloud auth login

gconf p
gcloud config set account thies.clasen@joblift.de

