#!/bin/bash

set -e

ISTIO_VERSION=1.18.1
TEMP_DIR=$(mktemp -d)
cd $TEMP_DIR

echo "download Istio ${ISTIO_VERSION}..."
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=${ISTIO_VERSION} sh -

export PATH="$TEMP_DIR/istio-${ISTIO_VERSION}/bin:$PATH"

istioctl install -y \
  --set profile=demo \
  --set components.ingressGateways[0].name=istio-ingressgateway \
  --set components.egressGateways[0].name=istio-egressgateway \
  --set values.gateways.istio-ingressgateway.type=NodePort \
  --set values.gateways.istio-egressgateway.type=NodePort

kubectl label namespace default istio-injection=enabled --overwrite

kubectl apply -f $TEMP_DIR/istio-${ISTIO_VERSION}/samples/addons/prometheus.yaml
kubectl apply -f $TEMP_DIR/istio-${ISTIO_VERSION}/samples/addons/kiali.yaml
kubectl apply -f $TEMP_DIR/istio-${ISTIO_VERSION}/samples/addons/grafana.yaml

kubectl wait --for=condition=ready pods --all -n istio-system --timeout=300s

kubectl patch svc -n istio-system istio-ingressgateway -p '{"spec":{"type":"NodePort"}}'

INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
SECURE_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
KIALI_PORT=$(kubectl -n istio-system get service kiali -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}')
MASTER_IP=$(kubectl get nodes -o jsonpath='{$.items[0].status.addresses[?(@.type=="InternalIP")].address}')

rm -rf $TEMP_DIR