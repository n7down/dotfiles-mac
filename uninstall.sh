#!/bin/bash

for i in _*
do
	rm -fr "${HOME}/${i/_/.}"
done
