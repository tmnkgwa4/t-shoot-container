REPOS_NAME=167855287371.dkr.ecr.ap-northeast-1.amazonaws.com
IMAGE_NAME:=nkgw/tshoot-tools
IMAGE_TAG:=0.2.4

build:
	DOCKER_BUILDKIT=1 docker build -t ${IMAGE_NAME} .

deploy: build
	aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin  ${REPOS_NAME}
	docker tag ${IMAGE_NAME} ${REPOS_NAME}/${IMAGE_NAME}:${IMAGE_TAG}
	docker push ${REPOS_NAME}/${IMAGE_NAME}:${IMAGE_TAG}
