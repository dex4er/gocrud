# SPDX-FileCopyrightText: 2023 Piotr Roszatycki <piotr.roszatycki@gmail.com>
#
# SPDX-License-Identifier: CC0-1.0

## Usage: goreleaser release --auto-snapshot --clean --skip-publish

FROM gcr.io/distroless/base-debian11:debug

COPY ./gocrud /usr/local/bin/gocrud

USER nonroot
ENTRYPOINT ["gocrud"]
