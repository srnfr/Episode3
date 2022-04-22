#!/bin/bash

for nsd in default blue; do

	NSDEBUG=$nsd
	LABEL="type=null"
	##LABEL="type=null,app=bookstore,role=api"

	DEBUGPODNAME=debug$RANDOM

	echo "#########################"
	kubectl run $DEBUGPODNAME --image=wbitt/network-multitool --restart=Never -l $LABEL -n $NSDEBUG

	echo "Waiting for creation to complete..."
	##echo "Namespace = $NSDEBUG"
	kubectl wait --for=condition=Ready pod/$DEBUGPODNAME -n $NSDEBUG

	kubectl get pod/$DEBUGPODNAME --show-labels -n $NSDEBUG

	for ns in red green blue; do
		svc=svc-echoserver.${ns}.svc
		echo "-----------"
		echo -n "Requete : NS=$NSDEBUG => ${svc}...  "
		kubectl exec -it $DEBUGPODNAME -n $NSDEBUG -- curl -s -i -w "%{http_code}" --connect-timeout 2 -o /dev/null http://${svc}
		echo ""
	done

	kubectl delete pod/$DEBUGPODNAME -n $NSDEBUG --wait=false

done
