echo "Do you want to clean up local branches that do not exist on remote? [y/n]"
read -r answer
if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo "Aborting..."
    exit 0
fi

echo "Fetching latest changes from remote..."
git fetch origin
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to fetch from remote. Please check your network connection and remote repository settings."
    exit 1
fi

echo "Cleaning up local branches that do not exist on remote..."

for branch in $(git branch --format '%(refname:short)'); do
    if ! git show-ref --verify --quiet refs/remotes/origin/$branch; then
        echo "Deleting local branch: $branch"
        git branch -D $branch
    fi
done
