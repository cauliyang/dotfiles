# Configuration

Welcome to my dotfiles repository! Here, I manage my configuration files (dotfiles) using Chezmoi, a powerful tool that helps handle diverse machine-specific configurations and secure management of secrets, and it also allows my dotfiles to be version controlled in a Git repository.
If you are a tech enthusiast, a programmer, or simply interested in setting up your computer for maximum efficiency, you're in the right place.

## What are Dotfiles?

Dotfiles are the customization files that are used to personalize your Linux or other Unix-based system.
You can tell that a file is a dotfile because the name of the file will start with a dot (`.`), but that dot is usually hidden in directory listings.
These configurations can be for any software that reads a file in your home directory for its configuration.

## Getting Started

Before diving in, I highly recommend taking a look at [Chezmoi's documentation](https://github.com/twpayne/chezmoi/blob/master/docs/README.md).
It'll give you a sense of how Chezmoi operates and how to manage your dotfiles.

### Prerequisites

- Unix-like operating system (Linux, MacOS, BSD, etc.)
- [Chezmoi](https://github.com/twpayne/chezmoi) installed on your machine.
- Basic knowledge of Git

### Installation

First, you need to clone this repository to your local machine:

```bash
git clone https://github.com/cauliyang/dotfiles
```

Then, navigate to the directory containing these dotfiles:

```bash
cd dotfiles
```

Finally, apply the dotfiles to your system:

```bash
chezmoi apply
```

**Note**: This will create symlinks for all config files in your home directory. You can safely run this command multiple times to update your system.

## How I Organize My Dotfiles

Each directory in this repository represents a program and the dotfiles associated with it. For instance, the `lvim` directory holds the configuration file for Neovim.

## Contributions

If you find an issue with my configurations or have any suggestions, please feel free to create an issue or submit a pull request.

## Acknowledgments

The open-source community has been a great source of inspiration in maintaining this repository.
If you're interested in more ways to manage your dotfiles, check out [dotfiles.github.io](https://dotfiles.github.io/).

## License This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).

That's it! Enjoy your journey with my configurations! Feel free to adapt them to match your personal taste.

## Contact Information

For any questions or suggestions, please feel free to contact me at:
`<yangyang.li@northwestern.edu>`
