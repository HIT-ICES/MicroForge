https://operatorhub.io/operator/elastic-cloud-eck
### steps
curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.22.0/install.sh | bash -s 0.22.0

kubectl create -f https://operatorhub.io/install/elastic-cloud-eck.yaml

kubectl apply -f *
### password
PASSWORD=$(kubectl get secret es-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')
