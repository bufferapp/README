CLUSTER_NAME = spark

info:
	@echo "Usage: make [TARGET]"
	@echo "Targets:"
	@echo "  - launch"
	@echo "  - stop"
	@echo "  - describe"
	@echo "  - login"
	@echo "  - destroy"

launch:
	flintrock --config ./config.yaml launch $(CLUSTER_NAME)

stop:
	flintrock --config ./config.yaml stop $(CLUSTER_NAME)

describe:
	flintrock --config ./config.yaml describe $(CLUSTER_NAME)

login:
	flintrock --config ./config.yaml login $(CLUSTER_NAME)

destroy:
	flintrock --config ./config.yaml destroy $(CLUSTER_NAME)
