FROM ubuntu:16.04
# Deepvariant runs on Ubuntu 14 or 16, 16 is recommended

MAINTAINER Madeline Kim <unikimma@gmail.com>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
	curl \
	git \
	python

# Clone deepvariant repository
RUN git clone https://github.com/google/deepvariant.git

# Install pre-requisites and build deepvariant
WORKDIR deepvariant
RUN mkdir bin
RUN mv build-prereq.sh bin
RUN mv build_and_test.sh bin
RUN mv run-prereq.sh bin
WORKDIR bin
RUN ./build-prereq.sh

# Test to make sure installation was successful
# RUN ./build_and_test.sh > pre_req_test_results.txt
RUN ./build_and_test.sh

# Install runtime dependencies and go back to deepvariant directory
RUN ./run-prereq.sh; cd -
