#!/bin/bash

# This file counts the system's users and groups.
# For each user, we print the UID and the groups of which the user if a member of.

num_users=`grep -v "^#" /etc/passwd | wc -l | tr -d "[:space:]"` # Alternativly, and more simply. Use "awk '{print $1}'" instead of "tr -d '[:space:]'"
num_groups=`grep -v "^#" /etc/group | wc -l | tr -d "[:space:]"`
usernames=`grep -v "^#" /etc/passwd | cut -d: -f1 | tr "\n" " "`

# When checking for the presence of the user's groups, sometimes the string is too long, 
# an error is then thrown, so we discard any errors.
exec 2>/dev/null

# Print simple info.
echo "We have ${num_users} users in this system."
echo "We have ${num_groups} groups in this system."

# Print each user, his UID and the groups which he is a member of.
for username in $usernames; do
    # Get the user ID
    uid= `grep "^${username}" /etc/passwd | cut -d: -f3`
    user_groups=`grep ${username} /etc/group | cut -d: -f1 | tr "\n" " "`

    # Printing...
    if [ -z $user_groups ]; 
    then
        printf "User: ${username} (UID=${uid}). Member of groups: None.\n";
    else 
        printf "User: ${username} (UID=${uid}). Member of groups: ${user_groups}\n";
    fi
done
