#!/bin/bash

NSDEBUG="blue"
LABEL="null"

DEBUGPODNAME=debug$RANDOM
kubectl run $DEBUGPODNAME --image=wbitt/network-multitool --restart=Never -l type=$LABEL -n $NSDEBUG

echo "Waiting for creation to complete..."
kubectl wait --for=condition=Ready pod/$DEBUGPODNAME -n $NSDEBUG

kubectl get pod/$DEBUGPODNAME --show-labels -n $NSDEBUG

for ns in red green blue; do
	svc=svc-echoserver.${ns}.svc
	echo "-----------"
	echo "Test vers ${svc}..."
	kubectl exec -it $DEBUGPODNAME -n $NSDEBUG -- curl -sv --styled-output --connect-timeout 2 -o /dev/null http://${svc}
	echo ""
	echo ""
done

kubectl delete pod/$DEBUGPODNAME --wait=false
