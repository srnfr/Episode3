#!/bin/bash

DEBUGPODNAME=debug$RANDOM
kubectl run $DEBUGPODNAME --image=wbitt/network-multitool --restart=Never -l type=debug

echo "Waiting for creation to complete..."
kubectl wait --for=condition=Ready pod/$DEBUGPODNAME

for ns in red green blue; do
	svc=svc-echoserver.${ns}.svc
	echo "-----------"
	echo "Test vers ${svc}..."
	kubectl exec -it $DEBUGPODNAME -- curl -sv --connect-timeout 3 -o /dev/null http://${svc}
	echo ""
	echo ""
done

kubectl delete pod/$DEBUGPODNAME --wait=false
