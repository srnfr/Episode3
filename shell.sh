#!/bin/bash

kubectl run -it --rm debug$RANDOM  --image=wbitt/network-multitool -- /bin/bash
