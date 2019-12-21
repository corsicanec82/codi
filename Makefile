ID := $(shell basename $(CURDIR))
IMAGE_ID := $(addsuffix _image, $(ID))
CONTAINER_ID := $(addsuffix _container, $(ID))
USER_ID := $(shell id -u)
GROUP_ID := $(shell id -g)
USER_NAME := user

build:
	docker build \
		--build-arg USER_ID=$(USER_ID) \
		--build-arg GROUP_ID=$(GROUP_ID) \
		--build-arg USER_NAME=$(USER_NAME) \
		--build-arg CURDIR=$(CURDIR) \
		-t $(IMAGE_ID) .

bash:
	docker run -it \
		--user=$(USER_ID):$(GROUP_ID) \
		-v $(CURDIR):/home/$(USER_NAME) \
		$(IMAGE_ID) /bin/bash

bash-root:
	docker run -it $(IMAGE_ID) /bin/bash

start:
	docker run -dt \
		--user=$(USER_ID):$(GROUP_ID) \
		-p 4000:80 \
		--name $(CONTAINER_ID) \
		$(IMAGE_ID)

stop:
	docker stop $(CONTAINER_ID)
