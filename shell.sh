#!/bin/bash

kubectl run -it --rm debug$RANDOM  -n default --image=wbitt/network-multitool -- /bin/bash
