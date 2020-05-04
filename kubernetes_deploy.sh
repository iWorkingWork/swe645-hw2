#!/usr/bin/env bash
# Should be switched to ubuntu user.
echo $USER
# First argument should be workspace directory.
WORKSPACE=$1
echo $WORKSPACE
cd $WORKSPACE
# Delete existing deployment on kubernetes.
kubectl delete -f swe645-hw2-kubernetes.yaml
# Deploy updated images
kubectl apply -f swe645-hw2-kubernetes.yaml
# Test
kubectl get all