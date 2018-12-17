#!/bin/bash

for i in _*
do
	rm -rf "${HOME}/${i/_/.}"
done

rm -rf ${HOME}/.bin
