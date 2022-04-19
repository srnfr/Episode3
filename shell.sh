#!/bin/bash

kubectl run -it --rm debug$RANDOM  -n blue --image=wbitt/network-multitool -- /bin/bash
