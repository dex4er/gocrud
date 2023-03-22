<!--
SPDX-FileCopyrightText: 2023 Piotr Roszatycki <piotr.roszatycki@gmail.com>

SPDX-License-Identifier: CC0-1.0
-->

# DevOps changes

Dear developers!

I made some changes to make CI/CD pipeline possible to run and few other small
changes that should improve DevEx.

- [asdf](https://asdf-vm.com/) (See [`.tool-versions`](.tool-versions))
- [golangci-lint](https://golangci-lint.run/) (See [`.golangci.yml`](.golangci.yml))
- [Trunk Check](https://trunk.io/products/check) (See [`.trunk`](.trunk))
- [GoReleaser](https://goreleaser.com/) (See [`.goreleaser.yaml`](.goreleaser.yaml))
- [Docker Engine](https://docs.docker.com/engine/) (See [`Dockerfile`](Dockerfile))
- [Docker Compose](https://docs.docker.com/compose/) (See [`docker-compose.yml`](docker-compose.yml))

Because I work with the clone of the original repository, I changed everywhere
in manifest the GitHub organization to `dex4er`. Please changed it back if you
want to apply the changes to your own repository.

## asdf

This ensures that everyone uses the same set of tools

Usage:

```sh
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2
. "$HOME/.asdf/asdf.sh"
while read plugin version; do asdf plugin add $plugin || test $? = 2; done < .tool-versions
asdf install
```

## golangci-lint

It is de-facto standard linter for Go.

Usage:

```sh
golangci-lint run
```

but it also is a part of Trunk Check.

## Trunk Check

Metalinter which lints and formats Dockerfile, GitHub Actions, Go, JSON,
Markdown, YAML and more.

It is a part of GitHub Actions pipelines and can be used directly:

```sh
curl https://get.trunk.io -fsSL | bash
trunk install
trunk check --all
```

Best used as [VScode plugin](https://marketplace.visualstudio.com/items?itemName=Trunk.io)

The additional [workflow](.github/workflows/trunk.yaml) is created so the
project is linter after each push.

## GoReleaser

Replaces Makefile and custom CI scripts with single tool for building and
publishing Go projects. It supports multi-OS and multi-arch builds.

Usage:

```sh
goreleaser release --auto-snapshot --clean --skip-publish
```

It will build binaries then container images.

The additional [workflow](.github/workflows/goreleaser.yaml) is created so new
container is built after each push.

## Docker Engine

Free version of GoReleaser works only with Docker Engine (Pro version with
Podman too). Our [`Dockerfile`](Dockerfile) does not compile the project: it
just copies binary built by GoReleaser from the right context.

The container images are now in
[`dex4er/gocrud`](https://hub.docker.com/r/dex4er/gocrud) repository.

## Docker Compose

The easiest way to run built application locally. After GoReleaser is used:

```sh
docker-compose up
```

We can switch to KIND (Kubernetes in Docker) as an alternative to run
applications locally but it will need more complex manifest.
