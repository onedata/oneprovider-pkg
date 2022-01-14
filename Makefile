# distro for package building (oneof: xenial, bionic, focal, centos-7-x86_64)
DISTRIBUTION            ?= none
RELEASE                 ?= $(shell cat ./RELEASE)
DOCKER_RELEASE          ?= development
DOCKER_REG_NAME         ?= "docker.onedata.org"
DOCKER_REG_USER         ?= ""
DOCKER_REG_PASSWORD     ?= ""
PROD_RELEASE_BASE_IMAGE ?= "onedata/oneprovider-common:2102-3"
DEV_RELEASE_BASE_IMAGE  ?= "onedata/oneprovider-dev-common:2102-7"
HTTP_PROXY              ?= "http://proxy.devel.onedata.org:3128"
RETRIES                 ?= 0
RETRY_SLEEP             ?= 300

ifeq ($(strip $(ONEPROVIDER_VERSION)),)
ONEPROVIDER_VERSION     := $(shell git describe --tags --always --abbrev=7)
endif
ifeq ($(strip $(COUCHBASE_VERSION)),)
COUCHBASE_VERSION       := 4.5.1-2844
endif
ifeq ($(strip $(CLUSTER_MANAGER_VERSION)),)
CLUSTER_MANAGER_VERSION := $(shell git -C cluster_manager describe --tags --always --abbrev=7)
endif
ifeq ($(strip $(OP_WORKER_VERSION)),)
OP_WORKER_VERSION       := $(shell git -C op_worker describe --tags --always --abbrev=7)
endif
ifeq ($(strip $(OP_PANEL_VERSION)),)
OP_PANEL_VERSION        := $(shell git -C onepanel describe --tags --always --abbrev=7)
endif

ONEPROVIDER_VERSION           := $(shell echo ${ONEPROVIDER_VERSION} | tr - .)
CLUSTER_MANAGER_VERSION       := $(shell echo ${CLUSTER_MANAGER_VERSION} | tr - .)
OP_WORKER_VERSION             := $(shell echo ${OP_WORKER_VERSION} | tr - .)
OP_PANEL_VERSION              := $(shell echo ${OP_PANEL_VERSION} | tr - .)

ONEPROVIDER_BUILD       ?= 1
PKG_BUILDER_VERSION     ?= -3

ifdef IGNORE_XFAIL
TEST_RUN := ./test_run.py --ignore-xfail
else
TEST_RUN := ./test_run.py
endif

ifdef ENV_FILE
TEST_RUN := $(TEST_RUN) --env-file $(ENV_FILE)
endif


GIT_URL := $(shell git config --get remote.origin.url | sed -e 's/\(\/[^/]*\)$$//g')
GIT_URL := $(shell if [ "${GIT_URL}" = "file:/" ]; then echo 'ssh://git@git.onedata.org:7999/vfs'; else echo ${GIT_URL}; fi)
ONEDATA_GIT_URL := $(shell if [ "${ONEDATA_GIT_URL}" = "" ]; then echo ${GIT_URL}; else echo ${ONEDATA_GIT_URL}; fi)
export ONEDATA_GIT_URL

.PHONY: docker docker-dev package.tar.gz

all: build

##
## Macros
##

NO_CACHE :=  $(shell if [ "${NO_CACHE}" != "" ]; then echo "--no-cache"; fi)

make = $(1)/make.py -s $(1) -r . $(NO_CACHE)
clean = $(call make, $(1)) clean
retry = RETRIES=$(RETRIES); until $(1) && return 0 || [ $$RETRIES -eq 0 ]; do sleep $(RETRY_SLEEP); RETRIES=`expr $$RETRIES - 1`; echo "===== Cleaning up... ====="; $(if $2,$2,:); echo "\n\n\n===== Retrying build... ====="; done; return 1 
make_rpm = $(call make, $(1)) -e DISTRIBUTION=$(DISTRIBUTION) -e RELEASE=$(RELEASE) --privileged --group mock -i onedata/rpm_builder:$(DISTRIBUTION)-$(RELEASE)$(PKG_BUILDER_VERSION) $(2)  
mv_rpm = mv $(1)/package/packages/*.src.rpm package/$(DISTRIBUTION)/SRPMS && \
	mv $(1)/package/packages/*.x86_64.rpm package/$(DISTRIBUTION)/x86_64
mv_noarch_rpm = mv $(1)/package/packages/*.src.rpm package/$(DISTRIBUTION)/SRPMS && \
	mv $(1)/package/packages/*.noarch.rpm package/$(DISTRIBUTION)/x86_64
make_deb = $(call make, $(1)) -e DISTRIBUTION=$(DISTRIBUTION) --privileged --group sbuild -i onedata/deb_builder:$(DISTRIBUTION)-$(RELEASE)$(PKG_BUILDER_VERSION) $(2)
mv_deb = mv $(1)/package/packages/*_amd64.deb package/$(DISTRIBUTION)/binary-amd64 && \
	mv $(1)/package/packages/*.tar.gz package/$(DISTRIBUTION)/source | true && \
	mv $(1)/package/packages/*.dsc package/$(DISTRIBUTION)/source | true && \
	mv $(1)/package/packages/*.diff.gz package/$(DISTRIBUTION)/source | true && \
	mv $(1)/package/packages/*.debian.tar.xz package/$(DISTRIBUTION)/source | true && \
	mv $(1)/package/packages/*.changes package/$(DISTRIBUTION)/source | true
mv_noarch_deb = mv $(1)/package/packages/*_all.deb package/$(DISTRIBUTION)/binary-amd64 && \
	mv $(1)/package/packages/*.tar.gz package/$(DISTRIBUTION)/source | true && \
	mv $(1)/package/packages/*.dsc package/$(DISTRIBUTION)/source | true && \
	mv $(1)/package/packages/*.diff.gz package/$(DISTRIBUTION)/source | true && \
	mv $(1)/package/packages/*.debian.tar.xz package/$(DISTRIBUTION)/source | true && \
	mv $(1)/package/packages/*.changes package/$(DISTRIBUTION)/source | true
unpack = tar xzf $(1).tar.gz

get_release:
	@echo $(RELEASE)

print_package_versions:
	@echo "oneprovider:\t\t" $(ONEPROVIDER_VERSION)
	@echo "cluster-manager:\t" $(CLUSTER_MANAGER_VERSION)
	@echo "op-worker:\t\t" $(OP_WORKER_VERSION)
	@echo "op-panel:\t\t" $(OP_PANEL_VERSION)

##
## Submodules
##

branch = $(shell git rev-parse --abbrev-ref HEAD)
submodules:
	git submodule sync --recursive ${submodule}
	git submodule update --init --recursive ${submodule}

##
## Build
##

build:  build_op_worker \
    build_cluster_manager build_cluster_worker build_onepanel

build_op_worker: submodules
	$(call make, op_worker)

build_cluster_manager: submodules
	$(call make, cluster_manager)

build_cluster_worker: submodules
	$(call make, cluster_worker)

build_onepanel: submodules
	$(call make, onepanel)

##
## Artifacts
##

artifact: artifact_op_worker \
    artifact_cluster_manager artifact_cluster_worker \
    artifact_onepanel

artifact_op_worker:
	$(call unpack, op_worker)

artifact_oz_worker:
	$(call unpack, oz_worker)

artifact_cluster_manager:
	$(call unpack, cluster_manager)

artifact_cluster_worker:
	$(call unpack, cluster_worker)

artifact_onepanel:
	$(call unpack, onepanel)

##
## Test
##

BROWSER             ?= Chrome
RECORDING_OPTION    ?= failed


test_provider_packaging test_packaging:
	$(call retry, ${TEST_RUN} --error-for-skips --test-type packaging -k "oneprovider" -vvv --test-dir tests/packaging -s)

##
## Clean
##

clean_all: clean_op_worker clean_onepanel clean_cluster_manager \
           clean_packages

clean_onepanel:
	$(call retry, $(call clean, onepanel))

clean_oz_worker:
	$(call retry, $(call clean, oz_worker))

clean_op_worker:
	$(call retry, $(call clean, op_worker))

clean_cluster_manager:
	$(call retry, $(call clean, cluster_manager))

clean_packages:
	rm -rf oneprovider_meta/oneprovider.spec \
		oneprovider_meta/oneprovider/DEBIAN/control \
		oneprovider_meta/package package 

##
## RPM packaging
##

rpm: rpm_oneprovider 

rpm_oneprovider: rpm_op_panel rpm_op_worker rpm_cluster_manager
	cp -f oneprovider_meta/oneprovider.spec.template oneprovider_meta/oneprovider.spec
	sed -i 's/{{scl}}/onedata$(RELEASE)/g' oneprovider_meta/oneprovider.spec
	sed -i 's/{{oneprovider_version}}/$(ONEPROVIDER_VERSION)/g' oneprovider_meta/oneprovider.spec
	sed -i 's/{{oneprovider_build}}/$(ONEPROVIDER_BUILD)/g' oneprovider_meta/oneprovider.spec
	sed -i 's/{{couchbase_version}}/$(COUCHBASE_VERSION)/g' oneprovider_meta/oneprovider.spec
	sed -i 's/{{cluster_manager_version}}/$(CLUSTER_MANAGER_VERSION)/g' oneprovider_meta/oneprovider.spec
	sed -i 's/{{op_worker_version}}/$(OP_WORKER_VERSION)/g' oneprovider_meta/oneprovider.spec
	sed -i 's/{{op_panel_version}}/$(OP_PANEL_VERSION)/g' oneprovider_meta/oneprovider.spec

	$(call retry, bamboos/docker/make.py -i onedata/rpm_builder:$(DISTRIBUTION)-$(RELEASE)$(PKG_BUILDER_VERSION) \
		    -e DISTRIBUTION=$(DISTRIBUTION) -e RELEASE=$(RELEASE) --privileged --group mock -c \
	        mock --buildsrpm --spec oneprovider_meta/oneprovider.spec \
	        --sources oneprovider_meta --root $(DISTRIBUTION) \
	        --resultdir oneprovider_meta/package/packages)

	$(call retry, bamboos/docker/make.py -i onedata/rpm_builder:$(DISTRIBUTION)-$(RELEASE)$(PKG_BUILDER_VERSION) \
		    -e DISTRIBUTION=$(DISTRIBUTION) -e RELEASE=$(RELEASE) --privileged --group mock -c \
	        mock --rebuild oneprovider_meta/package/packages/*.src.rpm \
	        --root $(DISTRIBUTION) --resultdir oneprovider_meta/package/packages)

	$(call mv_rpm, oneprovider_meta)

rpm_op_panel: clean_onepanel rpmdirs
	$(call retry, $(call make_rpm, onepanel, package) -e PKG_VERSION=$(OP_PANEL_VERSION) -e REL_TYPE=oneprovider, make clean_onepanel rpmdirs)
	$(call mv_rpm, onepanel)

rpm_op_worker: clean_op_worker rpmdirs
	$(call retry, $(call make_rpm, op_worker, package) -e PKG_VERSION=$(OP_WORKER_VERSION), make clean_op_worker rpmdirs)
	$(call mv_rpm, op_worker)

rpm_cluster_manager: clean_cluster_manager rpmdirs
	$(call retry, $(call make_rpm, cluster_manager, package) -e PKG_VERSION=$(CLUSTER_MANAGER_VERSION), make clean_cluster_manager rpmdirs)
	$(call mv_rpm, cluster_manager)

rpmdirs:
	mkdir -p package/$(DISTRIBUTION)/SRPMS package/$(DISTRIBUTION)/x86_64

##
## DEB packaging
##

deb: deb_oneprovider

deb_oneprovider: deb_op_panel deb_op_worker deb_cluster_manager
	cp -f oneprovider_meta/oneprovider/DEBIAN/control.template oneprovider_meta/oneprovider/DEBIAN/control
	sed -i 's/{{oneprovider_version}}/$(ONEPROVIDER_VERSION)/g' oneprovider_meta/oneprovider/DEBIAN/control
	sed -i 's/{{oneprovider_build}}/$(ONEPROVIDER_BUILD)/g' oneprovider_meta/oneprovider/DEBIAN/control
	sed -i 's/{{couchbase_version}}/$(COUCHBASE_VERSION)/g' oneprovider_meta/oneprovider/DEBIAN/control
	sed -i 's/{{cluster_manager_version}}/$(CLUSTER_MANAGER_VERSION)/g' oneprovider_meta/oneprovider/DEBIAN/control
	sed -i 's/{{op_worker_version}}/$(OP_WORKER_VERSION)/g' oneprovider_meta/oneprovider/DEBIAN/control
	sed -i 's/{{op_panel_version}}/$(OP_PANEL_VERSION)/g' oneprovider_meta/oneprovider/DEBIAN/control
	sed -i 's/{{distribution}}/$(DISTRIBUTION)/g' oneprovider_meta/oneprovider/DEBIAN/control

	bamboos/docker/make.py -s oneprovider_meta -r . -c 'dpkg-deb -b oneprovider'
	mv oneprovider_meta/oneprovider.deb \
		package/$(DISTRIBUTION)/binary-amd64/oneprovider_$(ONEPROVIDER_VERSION)-$(ONEPROVIDER_BUILD)~$(DISTRIBUTION)_amd64.deb

deb_op_panel: clean_onepanel debdirs
	$(call make_deb, onepanel, package) -e PKG_VERSION=$(OP_PANEL_VERSION) \
		-e REL_TYPE=oneprovider -e DISTRIBUTION=$(DISTRIBUTION)
	$(call mv_deb, onepanel)

deb_op_worker: clean_op_worker debdirs
	$(call make_deb, op_worker, package) -e PKG_VERSION=$(OP_WORKER_VERSION) \
		-e DISTRIBUTION=$(DISTRIBUTION)
	$(call mv_deb, op_worker)

deb_cluster_manager: clean_cluster_manager debdirs
	$(call make_deb, cluster_manager, package) -e PKG_VERSION=$(CLUSTER_MANAGER_VERSION) \
		-e DISTRIBUTION=$(DISTRIBUTION)
	$(call mv_deb, cluster_manager)

debdirs:
	mkdir -p package/$(DISTRIBUTION)/source package/$(DISTRIBUTION)/binary-amd64

##
## Package artifact
##

package.tar.gz:
	tar -chzf package.tar.gz package

##
## Docker artifact
##

docker: docker-dev
	./docker_build.py --repository $(DOCKER_REG_NAME) --user $(DOCKER_REG_USER) \
                      --password $(DOCKER_REG_PASSWORD) \
                      --build-arg BASE_IMAGE=$(PROD_RELEASE_BASE_IMAGE) \
                      --build-arg RELEASE=$(RELEASE) \
                      --build-arg RELEASE_TYPE=$(DOCKER_RELEASE) \
                      --build-arg OP_PANEL_VERSION=$(OP_PANEL_VERSION) \
                      --build-arg COUCHBASE_VERSION=$(COUCHBASE_VERSION) \
                      --build-arg CLUSTER_MANAGER_VERSION=$(CLUSTER_MANAGER_VERSION) \
                      --build-arg OP_WORKER_VERSION=$(OP_WORKER_VERSION) \
                      --build-arg ONEPROVIDER_VERSION=$(ONEPROVIDER_VERSION) \
                      --build-arg HTTP_PROXY=$(HTTP_PROXY) \
                      --name oneprovider \
                      --publish --remove docker

docker-dev:
	./docker_build.py --repository $(DOCKER_REG_NAME) --user $(DOCKER_REG_USER) \
                      --password $(DOCKER_REG_PASSWORD) \
                      --build-arg BASE_IMAGE=$(DEV_RELEASE_BASE_IMAGE) \
                      --build-arg RELEASE=$(RELEASE) \
                      --build-arg OP_PANEL_VERSION=$(OP_PANEL_VERSION) \
                      --build-arg COUCHBASE_VERSION=$(COUCHBASE_VERSION) \
                      --build-arg CLUSTER_MANAGER_VERSION=$(CLUSTER_MANAGER_VERSION) \
                      --build-arg OP_WORKER_VERSION=$(OP_WORKER_VERSION) \
                      --build-arg ONEPROVIDER_VERSION=$(ONEPROVIDER_VERSION) \
                      --build-arg HTTP_PROXY=$(HTTP_PROXY) \
                      --report docker-dev-build-report.txt \
                      --short-report docker-dev-build-list.json \
                      --name oneprovider-dev \
                      --publish --remove docker

codetag-tracker:
	./bamboos/scripts/codetag-tracker.sh --branch=${BRANCH} --excluded-dirs=node_package
