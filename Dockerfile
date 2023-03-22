## Usage: goreleaser release --auto-snapshot --clean --skip-publish

FROM gcr.io/distroless/base-debian11:debug

COPY ./gocrud /usr/local/bin/gocrud

USER nonroot
ENTRYPOINT ["gocrud"]
