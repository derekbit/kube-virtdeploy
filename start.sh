#!/bin/bash

pushd ./server
vagrant up
popd

sleep 30

pushd ./workers
vagrant up
popd
