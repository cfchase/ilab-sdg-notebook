# Jupiter notebook for running SDG

## Pre-requisites

* You will need to be a collaborator on the https://github.com/Red-Hat-AI-Innovation-Team/SDG-Research repo, reach out to `Abhishek Bhandwaldar` to get access.
* Setup a MaaS application using [Mixtral-8x7B-Instruct-v0.1](https://maas.apps.prod.rhoai.rh-aiservices-bu.com/admin/applications/new?service_id=mixtral-8x7b-instruct-v0-1), you will need to use this endpoint url and API Key
* Github access token with rights to read from repos: https://github.com/settings/tokens

## Creating the workbench

Create a workbench using the `Standard Data Science` image with a container size of `medium`, accelorator: `None`

Create two environment variables using the endpoint url and API key from the Mixtral-8x7B-Instruct application.

The first environment variable should be a Config Map -> Key / Value
* value: MIXTRAL_URL
* key: Endpoint url

The second environment variable should be a Secret -> Key / Value
* value: MIXTRAL_TOKEN
* key: API key

![image](assets/workbench-env.png)


## Prepairing the environment

Once the workbench it started, you will need to checkout this repository first.  

From the terminal run

`git clone https://github.com/rh-aiservices-bu/sdg-notebook.git`

You will need to enter your Github credentials (username and token)


