# Containers (Docker / Apptainer) and VSCode + AI assistants

This short guide explains how to retrieve images from Docker Hub and run them locally, how to use Apptainer (Singularity successor) on clusters, and quick tips for using VSCode with AI/code assistants (e.g. GitHub Copilot or ChatGPT extensions).

## Docker: pull and run

Docker is common on personal machines and servers where the Docker daemon is available.

- Pull an image from Docker Hub:

```bash
docker pull ubuntu:20.04
```

- Run an interactive shell inside the image:

```bash
docker run --rm -it ubuntu:20.04 bash
```

- Save an image to a tarball (optional, to transport without registry access):

```bash
docker save -o ubuntu_20.04.tar ubuntu:20.04
```

Note: on many HPC clusters Docker daemon is not available for security reasons.

## Apptainer (Singularity) — recommended on HPC

Apptainer (the community successor of Singularity) lets you run container images without requiring root privileges.

- Pull directly from Docker Hub (no Docker daemon needed):

```bash
# creates ubuntu_20.04.sif in current directory
apptainer pull docker://library/ubuntu:20.04
```

- Run a command inside a local SIF image:

```bash
apptainer exec ubuntu_20.04.sif bash
```

- Run the image (if it defines an entrypoint):

```bash
apptainer run ubuntu_20.04.sif
```

- Build a writable sandbox (requires root or user namespaces depending on system):

```bash
apptainer build --sandbox my_sandbox/ docker://ngs/myimage:latest
```

- Bind host paths (data directories) into container:

```bash
apptainer exec --bind /data:/data myimage.sif ls /data
```

### Tips when using Apptainer/Singularity with images from Docker Hub

- You can use `docker://` directly — Apptainer will pull and convert to a `.sif` image.
- If a private Docker registry is used, do `docker login` locally and use `apptainer build` from a docker-daemon: or use a registry token if supported.
- Prefer `.sif` images for immutable, reproducible runs. Use `--sandbox` only if you need a writable image during development.

## When Docker is available on a remote machine but not locally

You can `docker pull` on a machine that has Docker, `docker save` to a tarball, copy the tarball to the cluster, and then use Apptainer to build from the tar.

```bash
# on a machine with Docker
docker pull myorg/myimage:tag
docker save -o myimage.tar myorg/myimage:tag
scp myimage.tar user@cluster:/path/

# on the cluster (with apptainer)
apptainer build myimage.sif docker-archive://myimage.tar
```

## Quick security / reproducibility notes

- Pin versions in your image tags (avoid `:latest` for reproducible runs).
- Keep data outside containers and mount it at runtime (`--bind` / `-v`).
- Never bake secrets (passwords, tokens, keys) into container images.

## VSCode: remote editing and Git integration

- Use the **Remote - SSH** extension to edit files directly on remote servers. This avoids copying files back and forth.
- VSCode has built-in Git support (Source Control view). Use it for commits, branching and quick diffs.
- Configure your SSH keys and add them to the agent (`ssh-add`) so VSCode can use them.

## AI assistants in VSCode (GitHub Copilot, ChatGPT extensions)

There are several extensions that embed AI assistance inside VSCode. Common ones:

- GitHub Copilot (requires a license for some accounts)
- ChatGPT / CodeGPT community extensions (third-party)

Tips for safe and effective use:

- Do not paste secrets or confidential data into prompts.
- Use the assistant to generate snippets, explain code, or write tests — always review generated code.
- Provide the assistant with a minimal, focused context when asking for changes (open the file and select the relevant region before asking).
- For reproducible changes, turn suggested snippets into small, tested commits.

## Further reading / resources

- Apptainer docs: https://apptainer.org/
- Docker docs: https://docs.docker.com/
- VSCode Remote - SSH: https://code.visualstudio.com/docs/remote/ssh

