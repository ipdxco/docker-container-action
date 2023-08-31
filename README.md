# Docker Container Action

Docker Container Action is a GitHub Action that enables you to run Docker containers with custom run options, as well as pull or build images from scratch. This action is intended to address the limitations of GitHub's own [Docker container action](https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action), which does not allow for custom run options or specify the network the action should run in.

## How to migrate?

See how [jUnit XML to HTML](https://github.com/pl-strflt/junit-xml-to-html/pull/1/files#diff-1243c5424efaaa19bd8e813c5e6f6da46316e63761421b3e5f5c8ced9a36e6b6) action was migrated to Docker Container Action.

## Usage

To use the action, add the following step to your GitHub Actions workflow:

```
- name: Run Docker container
  uses: pl-strflt/docker-container-action@v1
  with:
    repository: owner/repo
    ref: main
```

### Inputs

* `repository`: The GitHub repository name. Required.
* `ref`: The GitHub repository ref. Required.
* `image`: The Docker image name. Optional; defaults to repository.
* `tag`: The Docker image tag. Optional; defaults to ref.
* `dockerfile`: The Dockerfile path. Optional; defaults to `Dockerfile`.
* `opts`: The Docker run options. Optional.
* `args`: The Docker run args. Optional.
* `build-args`: The Docker build args. Optional.
* `allow-exit-codes`: A comma separated list of exit code allowed when running the container. Use * to allow all exit codes
* `working-directory`: The Docker run working directory. Optional; defaults to `${{ github.workspace }}`.
* `github-server-url`: The GitHub server URL. Optional; defaults to `${{ github.server_url }}`.
* `docker-registry-url`: The Docker registry URL. Optional; defaults to `https://ghcr.io`.

### Outputs

* `outputs`: The outputs of the Docker run step in JSON format.

## How it works

When the Docker Container Action runs, it first checks if the specified image exists in the specified registry. If the image does not exist, it builds the image using the provided Dockerfile and git repository context. The action then runs the Docker container using the built or pulled image with the specified run options.

This action is commonly used inside a composite action. For example, if the composite action is defined in the `github/example` repository, you could use the Docker Container Action in a step with the following syntax:

```yml
- id: github
  name: Infer GitHub action repository and ref from GitHub action path
  uses: pl-strflt/docker-container-action/.github/actions/github@v1
- name: Run Docker container
  uses: pl-strflt/docker-container-action@v1
  with:
    repository: ${{ steps.github.outputs.action_repository }}
    ref: ${{ steps.github.outputs.action_ref }}
    opts: --network=host
    build-args: |
      CUSTOM_ARG_1:foo
      CUSTOM_ARG_2:bar
```

In this example, the composite action acts as a wrapper. When the step is executed, it first checks if the specified image exists. If it does not, it builds that image locally using the specified Dockerfile and git repository context. Finally, it runs the specified image with the custom options.

Assuming the composite action is defined in the `github/example` repository, and this action is used in a step with the following syntax:

```yml
- uses: github/example@v1
```

The Docker Container Action would first check if the image `ghcr.io/github/example@v1` exists in the specified Docker registry. If it does not, it would build that image locally using the `Dockerfile` in the `github.com/github/example#v1` context. Finally, it would run the `ghcr.io/github/example@v1` image with the specified run options.

You can find an example of how this action is used in the [IPFS Gateway Conformance](https://github.com/ipfs/gateway-conformance/blob/main/.github/actions/test/action.yml) repository.

---
