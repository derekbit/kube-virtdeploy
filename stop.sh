#!/bin/bash

pushd ./server
vagrant destroy
popd

pushd ./workers
vagrant destroy
popd
