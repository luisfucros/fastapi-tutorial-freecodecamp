AWS_REGION := $(shell eval "aws --profile default configure get region")
IMAGE_TAG := latest
ECR_NAME := ecr

IMAGE_NAME := api-testing
REPO_NAME := repo-testing

REGISTRY_ID := $(shell aws ecr \
		--profile default \
		describe-repositories \
		--query 'repositories[?repositoryName == `$(REPO_NAME)`].registryId' \
		--output text)

IMAGE_URI := $(REGISTRY_ID).dkr.ecr.$(AWS_REGION).amazonaws.com


ecr-repo:
		@echo "** Creating the ECR repository **"
		cd terraform && \
		terraform apply -target=aws_ecr_repository.$(ECR_NAME) -auto-approve

push-image:
		@echo "** Login to AWS ECR **"
		aws ecr get-login-password --region $(AWS_REGION) | \
		docker login --username AWS --password-stdin $(IMAGE_URI)

		@echo "** Building and pushing the container **"
		docker build -t $(IMAGE_URI)/$(REPO_NAME) -f api/LambdaDockerfile api/ && \
		docker push $(IMAGE_URI)/$(REPO_NAME):$(IMAGE_TAG)

deploy:
		@echo "** Deploying"
		cd terraform && \
		terraform apply -auto-approve