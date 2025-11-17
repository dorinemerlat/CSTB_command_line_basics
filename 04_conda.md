## Conda

Conda is a package manager and environment management system that helps you create isolated environments for Python projects (and not only!). It allows you to manage dependencies and ensures that each project has access to the correct packages without interfering with others.

## Conda vs Pip: key differences

Before diving into how to use Conda, it's important to understand how it compares to **pip**, the default package manager for Python. Both tools are used for installing packages and managing environments, but they have key differences:

**Conda**:
- Manages both **Python packages** and **non-Python dependencies** (e.g., system libraries like `libcurl`, `openssl`, etc.).
- Can create isolated environments that include both Python and system dependencies.
- Comes bundled with the Anaconda distribution, which includes many popular data science and machine learning packages.
- **Faster** at handling complex dependencies for scientific computing because it installs precompiled binaries.
  
**Pip**:
- A package manager for **Python packages** only.
- Requires a separate tool like **`virtualenv`** or **`venv`** to manage environments.
- **Slower** for packages with complex dependencies since it compiles from source.


## What is a virtual environment?

A **virtual environment** is an isolated workspace that allows you to install Python packages without affecting your system-wide Python installation. This is essential when working on multiple Python projects with different dependencies or versions of packages. Conda makes it easy to create and manage these isolated environments.

## Manage environment 

### Creating a conda environment

To create a new Conda environment, use the following command:

```bash
conda create -n <env_name> <package(s)>
```

Where:

- `<env_name>` is the name of the environment you want to create.
- `<package(s)>` are the packages you want to install (including the Python version).


Example:

```bash
conda create -n my_python python=3.9
```

This command creates a new Conda environment named `my_python` and installs Python with version 3.9 in it.

### Activating and deactivating an environment

Once you've created your environment, you need to activate it:

```bash
conda activate my_env
```

To deactivate and return to the base environment:

```bash
conda deactivate
```

### Removing a conda environment

To remove a Conda environment, use the following command:

```bash
conda env remove -n my_env
```

### List all environments

To list all Conda environments on your system:

```bash
conda env list
```

## Managing packages

### Installing packages in a conda environment

Once the environment is activated, you can install additional packages using the conda install command:

```bash
conda install numpy pandas
```

You can also install specific versions of packages:

```bash
conda install numpy=1.21.0
```

If you don't specify a version, Conda will install the latest version available.

If the version you want is not available in the default channels, you can search for it in other channels or add a new channel:

```bash
conda install -c conda-forge numpy
```

This command installs `numpy` from the `conda-forge` channel.

If the the version of package you try to install is not compatible with the Python version in the environment, Conda will try to find a compatible version. If it fails, it will show an error message.

### Removing packages

To remove a package from the environment, use the `conda remove` command:

```bash
conda remove numpy
```

### Updating packages

To update a package to the latest version:

```bash
conda update numpy
```

To update all packages in the environment:

```bash
conda update --all
```

### Listing installed packages

To list all packages installed in the environment:

```bash
conda list
```

## Requirements File

### Creating a Conda Environment from a Requirements File

You can define all your environment dependencies in a `yml` file and create an environment based on it. Here's an example of a file (`environment.yml`):

```yaml
name: my_env
channels:
  - defaults
dependencies:
  - python=3.9
  - numpy
  - pandas
  - scikit-learn
```

To create an environment from the file:

```bash
conda env create -f environment.yml
```

### Exporting a conda environment

To share or replicate your environment, you can export it to a `yml` file:

```bash
conda env export > environment.yml
```

This will capture all installed packages, including their versions and Python version, in the environment.yml file.

## Online repository of conda packages

To explore and browse packages available on Conda, you can visit: [Anaconda](https://anaconda.org/conda-forge). Here you can search for packages, explore their documentation, and get additional information on installation.

## Best practices for conda environments

- **Use isolated environments**: Always create a new environment for each project to avoid dependency conflicts.
- **Define environments with `yml` files**: This makes it easier to share and replicate environments.
- **Use Conda channels**: Conda channels are repositories that contain packages. The `default` is defaults, but you can add additional channels like `conda-forge` for a broader range of packages.

### Additional tips

- Use `mamba` (a faster reimplementation of the solver) when resolving complex environments: `mamba create -n env python=3.9 numpy` (mamba is drop-in replacement for many `conda` commands).
- When exporting environments for reproducibility prefer:

- If you mix `pip` and `conda` packages: prefer installing conda packages first, then `pip install` only the remaining packages.
- Clean package caches to save disk space: `conda clean --all`.
