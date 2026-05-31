#!/usr/bin/env bash

orig_directory=$(pwd)
template_path="5-Templates/Weekly plan template.md"

cd $NOTES_PATH
date_fmt="%Y-%m-%d"

# find the current day of the week
day_num=$(date +"%w")

# if today is sunday, then set start date to current day
if [[ day_num -eq 0 ]]; then 
    echo "today is sunday"
    start_date=$(date)

# if not, and it is thursday or later, then make the start date next sunday
elif [[ day_num -ge 4 ]]; then
    start_date=$(date -d "next sunday")
else 
    start_date=$(date -d "last sunday")
fi

end_date=$(date -d "${start_date} + 6 days")

start_date_fmt=$(date -d "${start_date}" +${date_fmt})
end_date_fmt=$(date -d "${end_date}" +${date_fmt})

echo "start date: ${start_date_fmt}"
echo "end date: ${end_date_fmt}"

file_name="Weekly planning ${start_date_fmt} - ${end_date_fmt}"

results=$(find ./**/* -name "${file_name}.md")

if [[ $results ]]; then
    nvim "${results}"
else
    full_path="./2-Writing/2-Planning/${file_name}.md"
    cp "${template_path}" "${full_path}"
    sed -i "s/Weekly Plan.*/Weekly Planning ${start_date_fmt} - ${end_date_fmt}/" "${full_path}"
    nvim "${full_path}"
fi

cd $orig_directory
