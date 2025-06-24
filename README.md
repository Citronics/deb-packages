# Citronics debian package repository

This repository is used to store the deb packages to be used on Citronics boards.

Run this command to add it to your source lists.

```
echo "deb [trusted=yes] https://raw.githubusercontent.com/Citronics/deb-packages/main stable main" | tee /etc/apt/sources.list.d/citronics.list

apt update
```

## License

By using any of the packages in this repo, you are accepting the licenses of all the individual packages. Check each package reposiroty for more information.
