export GOOGLE_APPLICATION_CREDENTIALS ?= $(shell pwd)/credentials/gcp.json

$(GOOGLE_APPLICATION_CREDENTIALS):
	mkdir -p credentials
	echo "$(GOOGLE_SERVICE_ACCOUNT)" | base64 -d > $(GOOGLE_APPLICATION_CREDENTIALS)

.PHONY: credentials
credentials: | $(GOOGLE_APPLICATION_CREDENTIALS)

environments/$(env)/.terraform:
	cd environments/$(env) ; terraform init -upgrade -backend=true  -backend-config=backend.cfg  ../../config/

.PHONY: clean
clean:
	rm -rf environments/$(env)/.terraform

.PHONY: init
init: | environments/$(env)/.terraform

.PHONY: plan
plan: init
	cd environments/$(env)	; terraform plan  ../../config
.PHONY: deploy
deploy: init
	cd environments/$(env)	; terraform apply -auto-approve ../../config

.PHONE: destroy
destroy: init
	cd environments/$(env)	; terraform destroy -auto-approve ../../config
