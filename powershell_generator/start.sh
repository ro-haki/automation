#!/bin/bash
set -e

templates="/templates"
public="/public"
volume_powerhsell_scripts="/powerhsell_scripts"
for ps_template in $templates/*.ps1; do

    filename=$(basename "$ps_template")
    cp "$ps_template" "${public}/$filename"
    
    while IFS='=' read -r key value; do
        safe_value=$(printf '%s\n' "$value" | sed -e 's/[\/&]/\\&/g')
        sed -i "s/{{${key}}}/$safe_value/g" "$public/$filename"
    done < <(env)
done

cp $public/* $volume_powerhsell_scripts/