# Project Setup and Tools

## Overview
This repository contains various scripts and tools designed to streamline project initialization and commit management. It includes:

- **`install.sh`**: Installs all necessary scripts and dependencies.
- **`pushnorme.sh`**: A commit helper script enforcing structured commit messages.
- **`init_project.sh`**: Automates the initialization of C, C++, and Haskell projects.
- **`epitest_docker`**: A Docker setup for running Epitech-style tests.

## Installation
To install all scripts and tools, run:
```bash
chmod +x install.sh
./install.sh
```

## `pushnorme.sh` - Commit Helper Script

### Usage
```bash
pushnorme.sh [type] [comment]
```

### Parameters
- `[type]` (optional) defines the type of commit:
  - `.` : Feature commit (default)
  - `-f` : Fix
  - `-d` : Documentation update
  - `-s` : Style improvements
  - `-rm` : Deletion
  - `-t` : Testing
  - `-b` : Build changes
  - `-m` : Merge
  - `-h` : Help menu
- `[comment]` is the commit message.

### Example
```bash
pushnorme.sh -f "Fixed memory leak in parser"
```

The script also ensures a successful build before committing. If the push fails, it attempts to set the upstream branch automatically.

---

## `init_project.sh` - Project Initialization Script

Create a project based on the Epitech requirements, works as a template but due to the way epitech's repo are created github templates don't work.

### Usage
```bash
init_project.sh [type] [project_name]
```

### Parameters
- `[type]` specifies the project type:
  - `-C` : C project
  - `-CPP` : C++ project
  - `-Hs` : Haskell project
- `[project_name]` is the name of the project.

### Features
- Creates required directories (`src`, `include` for C/C++ projects).
- Copies relevant template files.
- Replaces placeholders with the project name.
- Optionally initializes a Git repository.

### Example
```bash
init_project.sh -C my_project
```
This initializes a C project named `my_project`.

For Haskell projects, it updates `.cabal` and `package.yaml` files accordingly.

---

## ArchSetup - Base plugin and software when redumping

Not a lot to say about it, it install the base layer of software neede to work


## Additional Tools
- **`epitest_docker`**: A Dockerized testing environment.
- **`pushnorme_error`**: Logs errors when `pushnorme.sh` fails.
- **`HyDeWallpaper`**: Move a wallpaper into the selected theme folder for HyDe

## Contributing
Feel free to submit pull requests or open issues for improvements.

## License
This project is licensed under [MIT License](LICENSE).