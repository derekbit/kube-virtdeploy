#!/bin/bash

pushd ./server
vagrant up
popd

pushd ./workers
vagrant up
popd
