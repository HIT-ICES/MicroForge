#!/bin/bash

kubectl apply -f https://github.com/kubesphere/ks-installer/releases/download/v3.3.2/kubesphere-installer.yaml

cat <<EOF | kubectl apply -f -
apiVersion: installer.kubesphere.io/v1alpha1
kind: ClusterConfiguration
metadata:
  name: ks-installer
  namespace: kubesphere-system
spec:
  persistence:
    storageClass: ""  # storageClass name for your workspace
  etcd:
    monitoring: true
    endpointIps: localhost
    port: 2379
    tlsEnable: true
  common:
    redis:
      enabled: false
    openldap:
      enabled: false
    minioVolumeSize: 20Gi
    monitoring:
      endpoint: http://prometheus-operated.kubesphere-monitoring-system.svc:9090
  alerting:
    enabled: false
  auditing:
    enabled: false
  devops:
    enabled: false
  events:
    enabled: false
  logging:
    enabled: false
  metrics_server:
    enabled: true
  monitoring:
    storageClass: ""
  multicluster:
    clusterRole: none
  network:
    networkpolicy:
      enabled: false
    topology:
      type: none
  openpitrix:
    store:
      enabled: false
  servicemesh:
    enabled: false
EOF