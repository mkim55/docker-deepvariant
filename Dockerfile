FROM ubuntu:16.04
# Deepvariant runs on Ubuntu 14 or 16, 16 is recommended

MAINTAINER Madeline Kim <mkim15@gmail.com>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
	curl \
	git \
	python

# Clone deepvariant repository
WORKDIR /opt
RUN git clone https://github.com/google/deepvariant.git

# Install pre-requisites and build deepvariant
WORKDIR /opt/deepvariant
RUN mkdir /opt/deepvariant/bin
RUN cd /opt/deepvariant/bin
RUN bash /opt/deepvariant/build-prereq.sh

# Test to make sure installation was successful
# RUN ./build_and_test.sh > pre_req_test_results.txt
# RUN ./opt/deepvariant/build_and_test.sh

# Install runtime dependencies and go back to deepvariant directory
RUN bash /opt/deepvariant/run-prereq.sh #&& cd -
