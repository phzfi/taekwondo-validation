#!/bin/bash
URL="$1"
PAGE="$2"
UNIT_TAG=$(curl -sS "$URL/$PAGE" \
  | grep -oE 'name="_wpcf7_unit_tag" value="[^"]+"' \
  | sed -E 's/.*" value="([^"]+)".*/\1/' \
  | head -1)

CONTAINER_POST=$(curl -sS "$URL/$PAGE" \
  | grep -oE 'name="_wpcf7_container_post" value="[^"]+"' \
  | sed -E 's/.*" value="([^"]+)".*/\1/' \
  | head -1)

echo Expect validation error
curl -sS \
  -H "Referer: $URL/$PAGE" \
  -F "_wpcf7=488" \
  -F "_wpcf7_unit_tag=$UNIT_TAG" \
  -F "_wpcf7_container_post=$CONTAINER_POST" \
  -F "osallistuja=12345" \
  -F "date-698=1987-11-11" \
  -F "email-421=x@x.com" \
  -F "acceptance-349=1" \
  "$URL/wp-json/contact-form-7/v1/contact-forms/488/feedback"
